class seibertsoftwaresolutions::profile::httpd (
) {

  if defined(Class['apache']) == false {
    class { 'apache':
      default_vhost => false,
      default_mods  => false,
    }
  }

  include apache::mod::dir
  include apache::mod::headers
  include apache::mod::filter
  include apache::mod::proxy
  include apache::mod::proxy_http
  include apache::mod::deflate
  include apache::mod::php

  $filters = [
    'FilterDeclare   COMPRESS',
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'text/html'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'text/css'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'text/plain'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'application/json'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'application/javascript'\"",
    "FilterProvider  COMPRESS DEFLATE \"%{Content_Type} = 'image/svg+xml'\"",
    'FilterChain     COMPRESS',
    'FilterProtocol  COMPRESS DEFLATE change=yes;byteranges=no',
  ]

  if defined (Apache::Vhost['seibertsoftwaresolutions.com']) == false {
    apache::vhost { 'seibertsoftwaresolutions.com':
      docroot => '/var/www/html/seibertsoftwaresolutions',
      vhost_name => '*',
      port => 80,
      directoryindex => 'index.html',
    }
  }

  if defined (Service['httpd']) == false {
    service { 'httpd':
      enable => true,
      ensure => "running",
      require => Class['apache'],
    }
  }

  if defined(Selboolean['httpd_can_network_connect']) == false {
    selboolean { 'httpd_can_network_connect':
      persistent => true,
      value      => 'on',
    }
  }

}
