define systemd::networkd::network (
  String $priority = '60',
  String $filename = "${priority}-${title}.network",
  Array $sections = [],
) {
  validate_integer($priority)

  if $priority =~ /^1/ {
    fail('Priority may not start with 1 because everything matching /^1/ is ignored inside the managed /etc/systemd/network directory.')
  }

  systemd::networkd::config { $filename:
    sections => $sections,
  }
}
