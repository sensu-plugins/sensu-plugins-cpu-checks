## Sensu-Plugins-cpu-checks

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-cpu-checks.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-cpu-checks)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-cpu-checks.svg)](http://badge.fury.io/rb/sensu-plugins-cpu-checks)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-cpu-checks.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-cpu-checks)

## Functionality

## Files
 * bin/check-cpu.rb
 * bin/check-cpu.sh
 * bin/metrics-cpu-mpstat
 * bin/metrics-cpu-pcnt-usage
 * bin/metrics-user-pct-usage

## Usage

## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-cpu-checks -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-cpu-checks`

#### Bundler

Add *sensu-plugins-disk-checks* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-cpu-checks' do
  options('--prerelease')
  version '0.0.1'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-cpu-checks' do
  options('--prerelease')
  version '0.0.1'
end
```

## Notes
