# Definition: apache::vhost
#
# This class installs Apache Virtual Hosts
#
# Parameters:
# - The $port to configure the host on
# - The $docroot provides the DocumentationRoot variable
# - The $ssl option is set true or false to enable SSL for this Virtual Host
# - The $template option specifies whether to use the default template or override
# - The $priority of the site
# - The $serveraliases of the site
# - The $options for the given vhost
# - The $vhost_name for name based virtualhosting, defaulting to *
#
# Actions:
# - Install Apache Virtual Hosts
#
# Requires:
# - The apache class
#
# Sample Usage:
#  apache::vhost { 'site.name.fqdn':
#    priority => '20',
#    port => '80',
#    docroot => '/path/to/docroot',
#  }
#
define apache::vhost(
    $port,
    $docroot,
    $ssl           = hiera('apache_ssl'),
    $template      = hiera('apache_template'),
    $priority      = hiera('apache_priority'),
    $servername    = hiera('apache_servername'),
    $serveraliases = hiera('apache_serveraliases'),
    $auth          = hiera('apache_auth'),
    $redirect_ssl  = hiera('apache_redirect_ssl'),
    $options       = hiera('apache_options'),
    $apache_name   = $apache::params::apache_name,
    $vhost_name    = $apache::params::vhost_name
  ) {

  if $ssl {
    include apache::ssl
  } else {
    include apache
  }

  if $servername == '' {
    $srvname = $name
  } else {
    $srvname = $servername
  }

  # Since the template will use auth, redirect to https requires mod_rewrite
  if $redirect_ssl {
    case $::operatingsystem {
      'debian','ubuntu': {
        A2mod <| title == 'rewrite' |>
      }
      default: { }
    }
  }

  file {
    "${apache::params::vdir}/${priority}-${name}.conf":
      content => template($template),
      owner   => 'root',
      group   => 'root',
      mode    => '755',
      require => Package['httpd'],
      notify  => Service['httpd'],
  }

  # Do we have the firewall class?
  if defined(firewall) {
    @firewall { "0100-INPUT ACCEPT apache::vhost $port":
      action => 'accept',
      dport => $port,
      proto => 'tcp',
    }
  }
}

