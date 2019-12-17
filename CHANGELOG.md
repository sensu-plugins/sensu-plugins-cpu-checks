# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

### Changed
- Updated bundler development depedency to '~> 2.1'
### Added
- Updated asset build targets to support centos6

## [4.0.0] - 2019-04-18
### Breaking Changes
- Update minimum required ruby version to 2.3. Drop unsupported ruby versions.
- Bump `sensu-plugin` dependency from `~> 1.2` to `~> 4.0` you can read the changelog entries for [4.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#400---2018-02-17), [3.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#300---2018-12-04), and [2.0](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#v200---2017-03-29)

### Added
- Travis build automation to generate Sensu Asset tarballs that can be used n conjunction with Sensu provided ruby runtime assets and the Bonsai Asset Index
- Require latest sensu-plugin for [Sensu Go support](https://github.com/sensu-plugins/sensu-plugin#sensu-go-enablement)

## [3.0.0] - 2018-07-24
### Breaking Changes
- changing the default of `--sleep` from `1` to `5` this argument controls the time between initial poll and the followup poll which will get more overall accurate measurement of cpu utilization especially on systems that have less resources available (@majormoses)

## [2.1.0] - 2018-04-2018
### Added
- Added metrics-cpu-interrupts.rb (@yuri-zubov sponsored by Actility, https://www.actility.com)
- Added metrics-cpu-softirqs.rb (@yuri-zubov sponsored by Actility, https://www.actility.com)
- Added metrics-softnet-stat.rb (@yuri-zubov sponsored by Actility, https://www.actility.com)

## [2.0.1] - 2018-03-27
### Security
- updated yard dependency to `~> 0.9.11` per: https://nvd.nist.gov/vuln/detail/CVE-2017-17042 (@majormoses)

## [2.0.0] - 2018-03-07
### Security
- updated rubocop dependency to `~> 0.51.0` per: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8418. (@majormoses)

### Changed
- appeased the cops (@majormoses)

### Breaking Changes
- removed ruby `< 2.1` support (@majormoses)

## [1.1.3] - 2018-01-25
### Added
- ruby 2.4 testing (@majormoses)

### Fixed
- PR template spell "Compatibility" correctly (@majormoses)
- made bin executable (@majormoses)
- metrics-cpu.rb: fixed interrupt counters by taking the first column which is an aggregate of all interrupt stats  (@yuri-zubov)

### Changed
- updated Changelog guidelines location (@majormoses)

## [1.1.2] - 2017-06-20
### Fixed
- `metrics-cpu.rb`/`metrics-cpu-pcnt-usage.rb`: Set the correct type for --proc-path (@bimlendu)

## [1.1.1] - 2017-05-02
### Changed
- no real change just bumping due to deployment issue.

## [1.1.0] - 2017-05-02
### Added
- check-cpu.rb: added option to check less than (@santhosh-tekuri)
- check-cpu.rb: added option to use a cache file rather than sleeping to look at previous times (@axos88)

### Fixed
- Set the correct type for --proc-path (@envintus)
- metrics-cpu.rb was missing a column (@michau)

## [1.0.0] - 2016-06-15
### Changed
- Modified check-cpu.rb to change state if >= threshold
- Updated Rubocop to 0.40, applied auto-correct
- Loosened sensu-plugin dependency to ~> 1.2
- Specify the /proc location for use within a container

### Added
- Added metrics-numastat.rb
- check-cpu.rb: Added --idle-metrics flag for indicating counters which should be considered idle

### Removed
- Remove Ruby 1.9.3 support; add Ruby 2.3.0 support in test matrix

## [0.0.4] - 2015-09-29
### Changed
- Fix getopts syntax in check-cpu.sh
- Improvements to system/metrics-user-pct-usage.rb (option to use uid instead of username)

## [0.0.3] - 2015-07-14
### Changed
- updated sensu-plugin gem to 1.2.0

## [0.0.2] - 2015-06-02
### Fixed
- added binstubs

### Changed
- removed cruft from /lib

## 0.0.1 - 2015-05-21
### Added
- initial release


[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/4.0.0...HEAD
[4.0.0]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/3.0.0...4.0.0
[3.0.0]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/2.1.0...3.0.0
[2.1.0]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/2.0.1...2.1.0
[2.0.1]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/1.1.3...2.0.0
[1.1.3]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.4...1.0.0
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.1...0.0.2
