class systemd::journal (
  Boolean $purge_oldloggers = true,
) {
  if($::osfamily == 'debian') {
    if($purge_oldloggers) {
      package {'rsyslog':
        ensure => purged,
      }
    }
  }
}
