class systemd::networkd {
  include systemd
  service { 'systemd-networkd':
    ensure => 'running',
    enable => true,
  }

  if($::osfamily == 'debian') {
    service { 'networking':
      ensure  => stopped,
      enable  => mask,
      require => Service['systemd-networkd']
    }
    if($::lsbdistcodename == 'jessie') {
      file { '/etc/network/interfaces':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/systemd/networkd/etc_network_interfaces',
      }
    }
  }
  file { '/etc/systemd/network':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    purge   => true,
    recurse => true,
    ignore  => ['1*.link', '1*.netdev', '1*.network'],
    force   => true,
  }

  include systemd::networkd::default_network
}

