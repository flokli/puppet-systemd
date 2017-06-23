class systemd::resolved {
  include systemd
  if($::osfamily != 'Debian' and $::osfamily != 'Archlinux') {
    fail('so far, only tested on debian and arch family. pls fix!')
  }
  if($::lsbdistcodename == /(jessie|stretch|yakkety)/) {
    fail('so far, only tested on jessie, stretch and yakkety. pls fix!')
  }

  service { 'systemd-resolved':
    ensure  => 'running',
    enable  => true,
    require => Service['systemd-networkd']
  }

  file { '/etc/resolv.conf':
    ensure => link,
    target => '/run/systemd/resolve/resolv.conf',

    # use systemd-resolved directly. currently kind of unreliable
    # target => '/lib/systemd/resolv.conf',
  }
}
