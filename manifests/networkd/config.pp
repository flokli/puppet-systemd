define systemd::networkd::config (
  String $filename,
  Array $sections = {},
) {

  file { "/etc/systemd/network/${filename}":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => epp('systemd/networkd/config.epp', {
      'sections' => $sections,
    }),
    notify => Service['systemd-networkd'],
  }
}
