class systemd {
  if($::lsbdistcodename == 'jessie') {
    include apt
    include apt::backports
    apt::pin {'systemd-backports':
      packages => ['systemd', 'libsystemd0', 'libpam-systemd', 'libapparmor1', 'systemd-sysv', 'udev', 'libudev1', 'ifupdown'],
      release => 'jessie-backports',
      priority => 501,
      notify => Exec['apt_update'],
    }

    package {['systemd', 'systemd-sysv']:
      ensure => latest,
      require => Apt::Pin['systemd-backports'],
    }
  }
}

