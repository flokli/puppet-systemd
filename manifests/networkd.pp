class systemd::networkd (
  Hash $simple_networks = {}
) {
  include systemd

  service { 'systemd-networkd':
    ensure => 'running',
    enable => true,
  }

  if($::osfamily == 'debian') {
    if($::lsbdistcodename == 'jessie') {
      $enable_mask = false
    }
    else {
      $enable_mask = mask
    }
    service { 'networking':
      ensure  => stopped,
      enable  => $enable_mask,
      require => Service['systemd-networkd']
    }
    file { '/etc/network/interfaces':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/systemd/networkd/etc_network_interfaces',
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

  # lookup simple_networks in hiera and instantiate them
  create_resources(systemd::networkd::simple_network, $simple_networks)

  include systemd::networkd::default_network

}

