# Class: apache::data
#
# This class manages Apache parameters
#
# Parameters:
# - The $user that Apache runs as
# - The $group that Apache runs as
# - The $apache_name is the name of the package and service on the relevant distribution
# - The $php_package is the name of the package that provided PHP
# - The $ssl_package is the name of the Apache SSL package
# - The $apache_dev is the name of the Apache development libraries package
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class apache::data {

  $apache_user           = 'www-data'
  $apache_group          = 'www-data'
  $apache_ssl            = 'true'
  $apache_template       = 'apache/vhost-default.conf.erb'
  $apache_priority       = '25'
  $apache_servername     = ''
  $apache_serveraliases  = ''
  $apache_auth           = false
  $apache_redirect_ssl   = false
  $apache_options        = 'Indexes FollowSymLinks MultiViews'
  $apache_vhost_name     = '*'
  $apache_purge          = true
  $apache_package_ensure = present

  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific': {
       $apache_package_name   = 'httpd'
       $apache_service_name   = $apache_package_name
       $apache_php_package    = 'php'
       $apache_ssl_package    = 'mod_ssl'
       $apache_python_package = 'mod_python'
       $apache_wsgi_package   = 'mod_wsgi'
       $apache_dev_package    = 'httpd-devel'
       $apache_vdir           = '/etc/httpd/conf.d/'
    }
    'ubuntu', 'debian': {
       $apache_package_name   = 'apache2'
       $apache_service_name   = $apache_package_name
       $apache_php_package    = 'libapache2-mod-php5'
       $apache_ssl_package    = 'apache-ssl'
       $apache_python_package = 'libapache2-mod-python'
       $apache_wsgi_pacakge   = 'libapache2-mod-wsgi'
       $apache_dev_package    = [ 'libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev' ]
       $apache_vdir           = '/etc/apache2/sites-enabled/'
    }
  }

}
