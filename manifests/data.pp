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

  $apache_user          = 'www-data'
  $apache_group         = 'www-data'
  $apache_ssl           = 'true'
  $apache_template      = 'apache/vhost-default.conf.erb'
  $apache_priority      = '25'
  $apache_servername    = ''
  $apache_serveraliases = ''
  $apache_auth          = false
  $apache_redirect_ssl  = false
  $apache_options       = 'Indexes FollowSymLinks MultiViews'
  $apache_vhost_name    = '*'

  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific': {
       $apache_servicename = 'httpd'
       $php_package = 'php'
       $ssl_package = 'mod_ssl'
       $apache_dev_package  = 'httpd-devel'
       $vdir        = '/etc/httpd/conf.d/'
    }
    'ubuntu', 'debian': {
       $apache_name = 'apache2'
       $php_package = 'libapache2-mod-php5'
       $ssl_package = 'apache-ssl'
       $apache_dev_package  = [ 'libaprutil1-dev', 'libapr1-dev', 'apache2-prefork-dev' ]
       $vdir        = '/etc/apache2/sites-enabled/'
    }
  }

}
