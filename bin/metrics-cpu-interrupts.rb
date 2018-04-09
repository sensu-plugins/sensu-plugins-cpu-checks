#! /usr/bin/env ruby
#
#   metrics-cpu-interrupts
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
require 'sensu-plugins-cpu-checks'
require 'socket'

#
# CPU Graphite
#
class MetricsCPUInterrupts < Sensu::Plugin::Metric::CLI::Graphite
  include SensuPluginsCpuChecks::CommonInterrupts
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.interrupts"

  option :proc_path,
         long: '--proc-path /proc',
         proc: proc(&:to_s),
         default: '/proc'

  def run
    output_metrics('interrupts')
    ok
  end
end
