[![Sensu Bonsai Asset](https://img.shields.io/badge/Bonsai-Download%20Me-brightgreen.svg?colorB=89C967&logo=sensu)](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-cpu-checks)
[ ![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-cpu-checks.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-cpu-checks)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-cpu-checks.svg)](http://badge.fury.io/rb/sensu-plugins-cpu-checks)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-cpu-checks)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-cpu-checks.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-cpu-checks)

## Sensu Plugins CPU Checks Plugin

- [Overview](#overview)
- [Files](#files)
- [Usage examples](#usage-examples)
- [Configuration](#configuration)
  - [Sensu Go](#sensu-go)
    - [Asset registration](#asset-registration)
    - [Asset definition](#asset-definition)
    - [Check definition](#check-definition)
  - [Sensu Core](#sensu-core)
    - [Check definition](#check-definition)
- [Installation from source](#installation-from-source)
- [Additional notes](#additional-notes)
- [Contributing](#contributing)

### Overview

This plugin provides native CPU instrumentation for monitoring and metrics collection, including CPU usage and metrics for user, nice, system, idle, iowait, irq, softirq, steal, and guest.

### Files
 * bin/check-cpu.rb
 * bin/metrics-cpu-interrupts.rb
 * bin/metrics-cpu-mpstat.rb
 * bin/metrics-cpu-pcnt-usage.rb
 * bin/metrics-cpu-softirqs.rb
 * bin/metrics-cpu.rb
 * bin/metrics-numastat.rb
 * bin/metrics-softnet-stat.rb
 * bin/metrics-user-pct-usage.rb

	Added cpu interrupts, softirqs, softnet-stat	2 years ago
metrics-user-pct-usage.rb
 
**check-cpu**
Checks CPU usage.

**metrics-cpu-interrupts**
Provides metrics for CPU interrupts.

**metrics-cpu-mpstat**
Provides metrics for individual CPU and overall CPU usage.

**metrics-cpu-pcnt-usage**
Provides metrics for CPU percent usage.

**metrics-cpu-softirqs**
Provides metrics for CPU softirqs.

**metrics-cpu**
Provides CPU metrics.

**metrics-numastat**
Provides a simple wrapper around `numastat` for getting per-NUMA-node memory stats.

**metrics-softnet-stat**
Provides softnet stats.

**metrics-user-pct-usage**
Produces Graphite output of sum of %CPU over all processes by user. For example, if user Joe is running two processes, each using 10% CPU, and user Jane is running one process using 50% CPU, output will be:

* Joe 20.0 (timestamp)
* Jane 50.0 (timestamp)

## Usage examples

### Help

**check-cpu.rb**
```
Usage: check-cpu.rb (options)
        --cache-file CACHEFILE
    -c CRIT
        --guest                      Check cpu guest instead of total cpu usage
        --guest_nice                 Check cpu guest_nice instead of total cpu usage
        --idle                       Check cpu idle instead of total cpu usage
        --idle-metrics METRICS       Treat the specified metrics as idle. Defaults to idle,iowait,steal,guest,guest_nice
        --iowait                     Check cpu iowait instead of total cpu usage
        --irq                        Check cpu irq instead of total cpu usage
    -l, --less_than                  Change whether value is less than check
        --nice                       Check cpu nice instead of total cpu usage
        --proc-path /proc
        --sleep SLEEP                This sleep controls the interval between the initial poll for cpu utilization and the next data point, the longer the interval is the more accurate your data will be
        --softirq                    Check cpu softirq instead of total cpu usage
        --steal                      Check cpu steal instead of total cpu usage
        --system                     Check cpu system instead of total cpu usage
        --user                       Check cpu user instead of total cpu usage
    -w WARN  
```

**metrics-numastat.rb**
```
Usage: metrics-numastat.rb (options)
    -s, --scheme SCHEME              Metric naming scheme, text to prepend to metric
```

## Configuration
### Sensu Go
#### Asset registration

Assets are the best way to make use of this plugin. If you're not using an asset, please consider doing so! If you're using sensuctl 5.13 or later, you can use the following command to add the asset: 

`sensuctl asset add sensu-plugins/sensu-plugins-cpu-checks`

If you're using an earlier version of sensuctl, you can download the asset definition from [this project's Bonsai asset index page](https://bonsai.sensu.io/assets/sensu-plugins/sensu-plugins-cpu-checks).

#### Asset definition

```yaml
---
type: Asset
api_version: core/v2
metadata:
  name: sensu-plugins-cpu-checks
spec:
  url: https://assets.bonsai.sensu.io/68546e739d96fd695655b77b35b5aabfbabeb056/sensu-plugins-cpu-checks_4.0.0_centos_linux_amd64.tar.gz
  sha512: 518e7c17cf670393045bff4af318e1d35955bfde166e9ceec2b469109252f79043ed133241c4dc96501b6636a1ec5e008ea9ce055d1609865635d4f004d7187b
```

#### Check definition

```yaml
---
type: CheckConfig
spec:
  command: "check-cpu.rb"
  handlers: []
  high_flap_threshold: 0
  interval: 10
  low_flap_threshold: 0
  publish: true
  runtime_assets:
  - sensu-plugins/sensu-plugins-cpu-checks
  - sensu/sensu-ruby-runtime
  subscriptions:
  - linux
```

### Sensu Core

#### Check definition
```json
{
  "checks": {
    "check-cpu": {
      "command": "check-cpu.rb",
      "subscribers": ["linux"],
      "interval": 10,
      "refresh": 10,
      "handlers": ["influxdb"]
    }
  }
}
```

## Installation from source

### Sensu Go

See the instructions above for [asset registration](#asset-registration).

### Sensu Core

Install and setup plugins on [Sensu Core](https://docs.sensu.io/sensu-core/latest/installation/installing-plugins/).

## Additional notes

### Sensu Go Ruby Runtime Assets

The Sensu assets packaged from this repository are built against the Sensu Ruby runtime environment. When using these assets as part of a Sensu Go resource (check, mutator, or handler), make sure to include the corresponding [Sensu Ruby Runtime Asset](https://bonsai.sensu.io/assets/sensu/sensu-ruby-runtime) in the list of assets needed by the resource.

### Required `bc` utility

The `check-cpu.sh` shell script in this repository requires the `bc` utility to be installed and available in the executable path. This shell script is not installed when using the Ruby gem or Sensu asset derived from this repository.

## Contributing

See [CONTRIBUTING.md](https://github.com/sensu-plugins/sensu-plugins-cpu-checks/blob/master/CONTRIBUTING.md) for information about contributing to this plugin.
