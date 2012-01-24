# Class: apache
#
# This class installs Apache
#
# Parameters:
#
# Actions:
#   - Install Apache
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
class apache (
  $package = hiera_array('apache_package'),

  $purge   = hiera_array('apache_purge'),
) {

  package { 'httpd':
    name   => $package,
    ensure => installed,
  }

  service { 'httpd':
    name      => $service_name,
    ensure    => running,
    enable    => true,
    subscribe => Package['httpd'],
  }

  # May want to purge all none realize modules using the resources resource type.
  A2mod {
    require => Package['httpd'],
    notify  => Service['httpd'],
  }

  case $::operatingsystem {
    'debian','ubuntu': {
      @a2mod {
       'rewrite': ensure => present;
       'headers': ensure => present;
       'expires': ensure => present;
      }
    }
    default: { }
  }

  file { $apache::params::vdir:
    ensure  => directory,
    recurse => true,
    purge   => $purge,
    notify  => Service['httpd'],
  }

}
