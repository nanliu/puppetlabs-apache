class apache::mod::python (
  $package_name = hiera('apache_python_package')
) {

  include apache

  package { 'python':
    name    => $package_name,
    ensure  => installed,
    require => Package['httpd'];
  }

  a2mod { 'python':
    ensure => present
  }

}


