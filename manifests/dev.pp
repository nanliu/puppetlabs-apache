# Class: apache::dev
#
# This class installs Apache development libraries
#
# Parameters:
#
# Actions:
#   - Install Apache development libraries
#
# Requires:
#
# Sample Usage:
#
class apache::dev (
  $package = hiera_array('apache_dev_package')
) {

  package { $package:
    ensure => present,
  }

}
