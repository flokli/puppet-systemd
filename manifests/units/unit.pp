define systemd::units::unit (
  String $filename = "/etc/systemd/system/${title}",
  Array $sections = [],
) {
  include systemd::units::daemon_reload
  systemd::config { $filename:
    sections => $sections,
    notify   => Exec['systemd_systemctl_daemon_reload'],
  }
}
