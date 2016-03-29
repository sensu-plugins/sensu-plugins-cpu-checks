#Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format listed at [Keep A Changelog](http://keepachangelog.com/)

## [Unreleased]
### Changed
- modify check-cpu.rb to change state if >= threshold 

### Added
- add metrics-numastat.rb

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


[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.4...HEAD
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-cpu-checks/compare/0.0.1...0.0.2
