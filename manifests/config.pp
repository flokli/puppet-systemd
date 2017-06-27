define systemd::config (
  Array $sections = [],
) {
  file { $title:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('systemd/config.epp', {
      'sections' => $sections,
    }),
  }
}
