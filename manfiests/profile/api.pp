class seibertsoftwaresolutions::profile::api (
) {

  yumrepo { 'seibertsoftwaresolutions':
    name => 'seibertsoftwaresolutions',
    descr => 'seibertsoftwaresolutions',
    gpgcheck => 0,
    enabled => 1,
    mirrorlist => absent,
    repo_gpgcheck => 0,
    baseurl => 'http://104.131.253.44/repo',
    ensure => present,
    http_caching => 'none',
    metadata_expire => 1
  }

  if defined(Package['rubygems']) == false {
    package { 'rubygems':
      ensure => installed
    }
  }

  if defined(Class['nodejs']) == false {
    class { 'nodejs':
      version => 'v5.6.0',
      require => Package['rubygems']
    }
  }

  if defined(Package['pm2']) == false {
    package { 'pm2':
      provider => npm,
      install_options => ['-g'],
      ensure => '1.0.0',
      require => Class['nodejs'],
    }
  }

  if defined(User['node']) == false {
    user { 'node':
      ensure     => "present",
      managehome => true,
    }
  }

  if defined(Class['apache']) == false {
    class { 'apache':
      default_vhost => false,
      default_mods  => false,
    }
  }

  include apache::mod::proxy
  include apache::mod::proxy_http

  if defined (Service['httpd']) == false {
    service { 'httpd':
      enable => true,
      ensure => 'running',
      require => Class['apache'],
    }
  }

  if defined (Apache::Vhost['trackit-api.seibertsoftwaresolutions.com']) == false {
    apache::vhost { 'trackit-api.seibertsoftwaresolutions.com':
        priority   => 10,
        port       => 80,
        vhost_name => '*',
        proxy_pass => [{
          'path' => '/',
          'url' => 'http://localhost:9000/'
        }],
        docroot    => '/var/www/html',
     }
   }

  selboolean { 'httpd_can_network_connect':
    persistent => true,
    value      => 'on',
  }

  if defined (Package['trackit-api']) == false {
    package { 'trackit-api':
      ensure => 'latest',
      provider => 'yum',
      require => Package['pm2'],
    }
  }
}
