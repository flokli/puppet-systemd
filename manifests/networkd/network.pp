define systemd::networkd::network (
  String $filename = "60-${title}.network",
  Array $sections = [],
) {
  systemd::networkd::config { $filename:
    sections => $sections,
  }
}
