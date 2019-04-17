## Sensu-Plugins-cpu-checks

[ ![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-cpu-checks.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-cpu-checks)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-cpu-checks.svg)](http://badge.fury.io/rb/sensu-plugins-cpu-checks)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-cpu-checks.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-cpu-checks)
[![Sensu Bonsai Asset](https://img.shields.io/badge/Bonsai-Download%20Me-brightgreen.svg?colorB=89C967&logo=sensu)](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-cpu-checks)

## Sensu Asset  
  The Sensu assets packaged from this repository are built against the Sensu ruby runtime environment. When using these assets as part of a Sensu Go resource (check, mutator or handler), make sure you include the corresponding Sensu ruby runtime asset in the list of assets needed by the resource.  The current ruby-runtime assets can be found [here](https://bonsai.sensu.io/assets/sensu/sensu-ruby-runtime) in the [Bonsai Asset Index](bonsai.sensu.io).

## Functionality

## Files
 * bin/check-cpu.rb
 * bin/check-cpu.sh
 * bin/metrics-cpu-mpstat.rb
 * bin/metrics-cpu-pcnt-usage.rb
 * bin/metrics-numastat.rb
 * bin/metrics-user-pct-usage.rb

## Usage

## Installation

[Installation and Setup](http://sensu-plugins.io/docs/installation_instructions.html)

## Notes
The `check-cpu.sh` shell script in this repository requires the `bc` utility to be installed and available in the executable path. This shell script is not installed when using the Ruby gem or Sensu asset derived from this repository.
