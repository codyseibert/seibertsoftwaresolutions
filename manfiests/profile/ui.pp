class seibertsoftwaresolutions::profile::ui (
) {

  yumrepo { 'codyseibert':
    name => 'codyseibert',
    descr => 'codyseibert',
    gpgcheck => 0,
    enabled => 1,
    mirrorlist => absent,
    repo_gpgcheck => 0,
    baseurl => 'http://104.131.253.44/repo',
    ensure => present,
    http_caching => 'none',
    metadata_expire => 1
  }

  if defined (Firewall['100 allow http and https access']) == false {
    firewall { '100 allow http and https access':
      dport   => [80, 443],
      proto  => tcp,
      action => accept,
    }
  }

  if defined(Class['apache']) == false {
    class { 'apache':
      default_vhost => false,
      default_mods  => false,
    }
  }

  include apache::mod::dir

  if defined (Apache::Vhost['seibertsoftwaresolutions.codyseibert.com']) == false {
    apache::vhost { 'seibertsoftwaresolutions.codyseibert.com':
      docroot => '/var/www/html/seibertsoftwaresolutions-ui',
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

  if defined (Package['seibertsoftwaresolutions-ui']) == false {
    package { 'seibertsoftwaresolutions-ui':
      ensure => 'latest',
      provider => 'yum',
    }
  }
}
