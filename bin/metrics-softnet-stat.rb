#! /usr/bin/env ruby
#
#   metrics-softnet-stat
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
#   Zubov Yuri <yury.zubau@gmail.com> sponsored by Actility, https://www.actility.com
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#
require 'sensu-plugin/metric/cli'
require 'socket'

#
# CPU Graphite
#
class MetricsSoftnetStat < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.softnet-stat"

  option :proc_path,
         long: '--proc-path /proc',
         proc: proc(&:to_s),
         default: '/proc'

  def run
    name_metrics = %w[processed dropped time_squeeze cpu_collision received_rps flow_limit_count]

    File.open("#{config[:proc_path]}/net/softnet_stat", 'r').each_line.with_index do |line, cpu_index|
      result = line.split(' ')
      array = result[0..2] + result[-3..-1]
      array.each_with_index do |value, index|
        output "#{config[:scheme]}.CPU#{cpu_index}.#{name_metrics[index]}", value.to_i(16)
      end
    end
    ok
  end
end
