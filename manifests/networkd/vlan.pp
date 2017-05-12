define systemd::networkd::vlan (
  Optional[Integer] $id,
) {
  systemd::networkd::netdev { $title:
    kind => 'vlan',
    sections => [
      {'VLAN' => {
        'Id' => $id,
      }}
    ],
  }
}
