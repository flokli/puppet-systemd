define systemd::networkd::link (
  String $filename = "60-${title}.link",
  Array $sections = {}
) {
  systemd::networkd::config { $filename:
    sections => $sections,
  }
}
