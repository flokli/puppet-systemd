class systemd {
  if($::operatingsystem == 'Debian' and $::operatingsystemrelease < '8') {
    fail('At least Debian Jessie required for systemd')
  }
  if($::operatingsystem == 'Ubuntu' and $::operatingsystemrelease < '16.10') {
    fail('At least Ubuntu Yakkety required for systemd')
  }

  package {'systemd':
    ensure => latest,
  }

  if($::osfamily == 'Debian') {
    # install systemd-sysv on Debian osfamily
    package {'systemd-sysv':
      ensure  => latest,
    }

    # on jessie, pin systemd from backports
    if($::lsbdistcodename in ['jessie', 'stretch']) {
      include apt
      include apt::backports

      if($::lsbdistcodename == 'jessie') {
        apt::pin {'systemd-backports':
          packages => ['systemd', 'libsystemd0', 'libpam-systemd', 'libapparmor1', 'systemd-sysv', 'udev', 'libudev1', 'ifupdown'],
          release  => "${::lsbdistcodename}-backports",
          priority => 501,
          notify   => Exec['apt_update'],
        }
        Apt::Pin['systemd-backports'] -> Package['systemd']
      }
      if($::lsbdistcodename == 'stretch') {
        apt::pin {'systemd-unstable':
          packages => ['systemd', 'libsystemd0', 'libpam-systemd', 'libapparmor1', 'systemd-sysv', 'udev', 'libudev1', 'ifupdown'],
          release  => 'unstable',
          priority => 501,
          notify   => Exec['apt_update'],
        }
        Apt::Pin['systemd-unstable'] -> Package['systemd']
      }
      Class['apt::update'] -> Package['systemd']
    }
  }
}

