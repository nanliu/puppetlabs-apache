class apache::mod::python (
  $package_name   = hiera('apache_python_package'),
  $package_ensure = hiera('apache_pachage_ensure')
) {

  include apache

  package { 'python':
    name    => $package_name,
    ensure  => $package_ensure,
    require => Package['httpd'];
  }

  case $::osfamily {
    'debian': {
      a2mod { 'python':
        ensure => present
      }
    }
  }

}
