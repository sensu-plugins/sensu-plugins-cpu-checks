#!/usr/bin/env ruby
#
#   metrics-numastat
#
# DESCRIPTION:
#   Simple wrapper around `numastat` for getting per-NUMA-node memory stats.
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
#   Copyright 2016 Mitsutoshi Aoe
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'socket'
require 'sensu-plugin/metric/cli'

class NumastatMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.numastat"

  def run
    begin
      output = `/usr/bin/numastat`
    rescue Errno::ENOENT => err
      unknown err
    end

    nodes = []
    output.each_line do |line|
      nodes = line.split(' ') if nodes.empty?
      next unless /^([^\s]+)\s+(.+)$/ =~ line
      key = Regexp.last_match[1]
      vals = Regexp.last_match[2]
      next if key.nil? || vals.nil?
      nodes.zip(vals.split(' ')).each do |node, val|
        output "#{config[:scheme]}.#{node}.#{key}", val
      end
    end

    ok
  end
end
