#! /usr/bin/env ruby

#
#   cpu-metrics
#
# DESCRIPTION:
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#
# NOTES:
#
# LICENSE:
#   Copyright 2012 Sonian, Inc <chefs@sonian.net>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#
require 'sensu-plugin/metric/cli'
require 'socket'

#
# CPU Graphite
#
class CpuGraphite < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.cpu"

  option :proc_path,
         long: '--proc-path /proc',
         proc: proc(&:to_s),
         default: '/proc'

  def run
    cpu_metrics = %w[user nice system idle iowait irq softirq steal guest guest_nice]
    other_metrics = %w[ctxt processes procs_running procs_blocked btime intr]
    cpu_count = 0

    File.open("#{config[:proc_path]}/stat", 'r').each_line do |line|
      info = line.split(/\s+/)
      next if info.empty?
      name = info.shift

      if name =~ /cpu([0-9]+|)/
        # #YELLOW
        cpu_count = cpu_count + 1 # rubocop:disable Style/SelfAssignment
        name = 'total' if name == 'cpu'
        info.size.times { |i| output "#{config[:scheme]}.#{name}.#{cpu_metrics[i]}", info[i] }
      end

      output "#{config[:scheme]}.#{name}", info.first if other_metrics.include? name
    end
    if cpu_count > 0
      # writes the number of cpus, the minus 1 is because /proc/stat/
      # first line is a "cpu" which is stats for total cpus
      output "#{config[:scheme]}.cpu_count", cpu_count - 1
    end

    ok
  end
end
