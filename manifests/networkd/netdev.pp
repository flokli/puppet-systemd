define systemd::networkd::netdev (
  Optional[String] $description = undef,
  Optional[String] $kind = undef,
  Optional[String] $mtu_bytes = undef,
  Optional[String] $mac_address = undef,
  String $filename = "60-${title}.netdev",
  Array $sections = []
) {
  # assemble [NetDev] section
  $netdev_section = {
    'Name' => $title,
    'Description' => $description,
    'Kind' => $kind,
    'MTUBytes' => $mtu_bytes,
    'MACAddress' => $mac_address,
  }.filter |$k, $v| { $v != undef }

  systemd::networkd::config { "${title}.netdev":
    filename => $filename,
    sections => [{'NetDev' => $netdev_section}] + $sections,
  }
}
