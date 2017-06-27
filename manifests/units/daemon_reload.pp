class systemd::units::daemon_reload {
  exec {'systemd_systemctl_daemon_reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }
}
