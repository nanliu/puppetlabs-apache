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
  $package_name   = hiera('apache_dev_package'),
  $package_ensure = hiera('apache_package_ensure')
) {

  include apache

  package { $package_name:
    ensure => $package_ensure,
  }

}
