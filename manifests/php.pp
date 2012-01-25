# Class: apache::php
#
# This class installs PHP for Apache
#
# Parameters:
# - $php_package
#
# Actions:
#   - Install Apache PHP package
#
# Requires:
#
# Sample Usage:
#
class apache::php (
  $package_name   = hiera('apache_php_package'),
  $package_ensure = hiera('apache_package_ensure')
) {

  include apache
  include php

  package { $package_name:
    ensure => $package_ensure,
  }

}
