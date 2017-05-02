#! /usr/bin/env ruby
#
#   check-cpu
#
# DESCRIPTION:
#   Check cpu usage
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   #YELLOW
#
# NOTES:
#
# LICENSE:
#   Copyright 2014 Sonian, Inc. and contributors. <support@sensuapp.org>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/check/cli'
require 'json'

#
# Check CPU
#
class CheckCPU < Sensu::Plugin::Check::CLI
  CPU_METRICS = [:user, :nice, :system, :idle, :iowait, :irq, :softirq, :steal, :guest, :guest_nice].freeze

  option :less_than,
         description: 'Change whether value is less than check',
         short: '-l',
         long: '--less_than',
         default: false,
         boolean: true

  option :warn,
         short: '-w WARN',
         proc: proc(&:to_f),
         default: 80

  option :crit,
         short: '-c CRIT',
         proc: proc(&:to_f),
         default: 100

  option :sleep,
         long: '--sleep SLEEP',
         proc: proc(&:to_f),
         default: 1

  option :cache_file,
         long: '--cache-file CACHEFILE',
         default: nil

  option :proc_path,
         long: '--proc-path /proc',
         proc: proc(&:to_s),
         default: '/proc'

  option :idle_metrics,
         long: '--idle-metrics METRICS',
         description: 'Treat the specified metrics as idle. Defaults to idle,iowait,steal,guest,guest_nice',
         proc: proc { |x| x.split(/,/).map { |y| y.strip.to_sym } },
         default: [:idle, :iowait, :steal, :guest, :guest_nice]

  CPU_METRICS.each do |metric|
    option metric,
           long: "--#{metric}",
           description: "Check cpu #{metric} instead of total cpu usage",
           boolean: true,
           default: false
  end

  def acquire_cpu_stats
    File.open("#{config[:proc_path]}/stat", 'r').each_line do |line|
      info = line.split(/\s+/)
      name = info.shift
      return info.map(&:to_f) if name =~ /^cpu$/
    end
  end

  def acquire_stats_with_sleeping(sec)
    before = acquire_cpu_stats
    sleep sec
    after = acquire_cpu_stats

    [before, after]
  end

  def acquire_stats_with_cache_file
    before = JSON.parse(File.read(config[:cache_file]))
    now = acquire_cpu_stats

    [before, now]
  end

  def write_stats_to_cache_file(data)
    File.write(config[:cache_file], data)
  end

  def acquire_stats(sec)
    if config[:cache_file] && File.exist?(config[:cache_file])
      (before, now) = acquire_stats_with_cache_file
    else
      (before, now) = acquire_stats_with_sleeping(sec)
    end

    write_stats_to_cache_file(now) if config[:cache_file]

    [before, now]
  end

  def run
    (cpu_stats_before, cpu_stats_now) = acquire_stats(config[:sleep])

    # Some kernels don't have 'guest' and 'guest_nice' values
    metrics = CPU_METRICS.slice(0, cpu_stats_now.length)

    cpu_total_diff = 0.to_f
    cpu_stats_diff = []
    metrics.each_index do |i|
      cpu_stats_diff[i] = cpu_stats_now[i] - cpu_stats_before[i]
      cpu_total_diff += cpu_stats_diff[i]
    end

    cpu_stats = []
    metrics.each_index do |i|
      cpu_stats[i] = 100 * (cpu_stats_diff[i] / cpu_total_diff)
    end

    idle_diff = metrics.each_with_index.map { |metric, i| config[:idle_metrics].include?(metric) ? cpu_stats_diff[i] : 0.0 }.reduce(0.0, :+)

    cpu_usage = 100 * (cpu_total_diff - idle_diff) / cpu_total_diff
    checked_usage = cpu_usage

    self.class.check_name 'CheckCPU TOTAL'
    metrics.each do |metric|
      if config[metric]
        self.class.check_name "CheckCPU #{metric.to_s.upcase}"
        checked_usage = cpu_stats[metrics.find_index(metric)]
      end
    end

    msg = "total=#{(cpu_usage * 100).round / 100.0}"
    cpu_stats.each_index { |i| msg += " #{metrics[i]}=#{(cpu_stats[i] * 100).round / 100.0}" }

    message msg

    if config[:less_than]
      critical if checked_usage <= config[:crit]
      warning if checked_usage <= config[:warn]
    else
      critical if checked_usage >= config[:crit]
      warning if checked_usage >= config[:warn]
    end
    ok
  end
end
