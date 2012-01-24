class apache::mod::wsgi (
  $package_name = hiera('apache_wsgi_package'),
  $package_ensure = hiera('apache_package_ensure')
) {

  include apache

  package { 'wsgi':
    name    => $package_name,
    ensure  => $package_ensure,
    require => Package['httpd'];
  }

  a2mod { 'wsgi':
    ensure => present
  }

}

