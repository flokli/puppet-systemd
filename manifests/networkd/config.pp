define systemd::networkd::config (
  Array $sections = [],
) {

  systemd::config { "/etc/systemd/network/${title}":
    sections => $sections,
    notify   => Service['systemd-networkd'],
  }
}
