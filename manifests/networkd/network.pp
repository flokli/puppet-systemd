define systemd::networkd::network (
  String $filename = "60-${title}.network",
  Array $sections = [],
) {
  systemd::networkd::config { "${title}.network":
    filename => $filename,
    sections => $sections,
  }
}
