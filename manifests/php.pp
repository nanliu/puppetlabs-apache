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
class apache::php inherits apache::data {
  include php

  package { $apache::params::php_package:
    ensure => present,
  }

}
