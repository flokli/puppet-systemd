define systemd::networkd::simple_network (
  Optional[String] $match_mac_address = undef,
  Optional[String] $match_path = undef,
  Optional[String] $match_driver = undef,
  Optional[String] $match_type = undef,
  Optional[String] $match_name = undef,
  Optional[String] $match_host = undef,
  Optional[String] $match_virtualization = undef,
  Optional[String] $match_kernel_command_line = undef,
  Optional[String] $match_architecture = undef,

  Enum['yes', 'no', 'ipv4', 'ipv6'] $network_dhcp = 'yes',
  Optional[Variant[String, Array[String]]] $network_address = undef,
  Optional[Variant[String, Array[String]]] $network_gateway = undef,
  Optional[Variant[String, Array[String]]] $network_dns = undef,
  Optional[Variant[String, Array[String]]] $network_domains = undef,
  Optional[String] $network_ipv6_token = undef,
  Optional[Boolean] $network_ipv6_accept_ra = undef,
  Optional[Boolean] $network_unmanaged = undef,

  Array[Hash] $additional_sections = [],
) {

  systemd::networkd::network { $title:
    sections => [
      {'Match' => {
        'MACAddress'        => $match_mac_address,
        'Path'              => $match_path,
        'Driver'            => $match_driver,
        'Type'              => $match_type,
        'Name'              => $match_name,
        'Host'              => $match_host,
        'Virtualization'    => $match_virtualization,
        'KernelCommandLine' => $match_kernel_command_line,
        'Architecture'      => $match_architecture,
      }.filter |$k, $v| { $v != undef }},
      {'Network' => {
        'DHCP'         => $network_dhcp,
        'Address'      => $network_address,
        'Gateway'      => $network_gateway,
        'DNS'          => $network_dns,
        'Domains'      => $network_domains,
        'IPv6Token'    => $network_ipv6_token,
        'IPv6AcceptRA' => $network_ipv6_accept_ra,
        'Unmanaged'    => $network_unmanaged,
      }.filter |$k, $v| { $v != undef }}
    ] + $additional_sections,
  }
}
