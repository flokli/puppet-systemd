define systemd::networkd::bonding (
  Enum['balance-rr',
        'active-backup',
        'balance-xor',
        'broadcast',
        '802.3ad',
        'balance-tlb',
        'balance-alb'] $mode = '802.3ad',
  Enum['layer2',
        'layer2+3',
        'layer3+4',
        'encap2+3',
        'encap3+4'] $transmit_hash_policy = undef,

  Optional[String] $match_mac_address = undef,
  Optional[String] $match_path = undef,
  Optional[String] $match_driver = undef,
  Optional[String] $match_type = undef,
  Optional[String] $match_name = undef,
  Optional[String] $match_host = undef,
  Optional[String] $match_virtualization = undef,
  Optional[String] $match_kernel_command_line = undef,
  Optional[String] $match_architecture = undef,
) {
  systemd::networkd::netdev { $title:
    kind     => 'bond',
    sections => [
      {'Bond' => {
        'Mode'               => $mode,
        'TransmitHashPolicy' => $transmit_hash_policy,
      }.filter |$k, $v| { $v != undef }},
    ],
  }

  systemd::networkd::network { "enslave-${title}":
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
        'Bond' => $title,
      }}
    ]
  }
}
