# private class, do not use directly
# steers the cups server configuration

class cups::server::config (
  $printers,
  $default_printer,
  $cups_user,
  $cups_group,
) {

  file { '/etc/cups/printcap':
    ensure  => file,
    require => Package['cups'],
    owner   => 'root',
    group   => $cups_group,
    mode    => '0644',
    notify  => Service['cupsd'],
    content => template("${module_name}/printcap.erb"),
  }

  file { '/etc/cups/printers.conf.puppet':
    ensure  => file,
    require => Package['cups'],
    owner   => 'root',
    group   => $cups_group,
    mode    => '0600',
    notify  => Service['cupsd'],
    content => template("${module_name}/printers.conf.erb"),
  }
  exec { 'cups_sane_copy_printers.conf':
    command     => '/bin/cp /etc/cups/printers.conf.puppet /etc/cups/printers.conf',
    unless      => 'grep LaserJet /etc/cups/printers.conf 2>/dev/null',
    subscribe   => File['/etc/cups/printers.conf.puppet'],
    notify      => Service['cupsd'],
    refreshonly => true,
  }

  $printers.each |Integer $index, String $printer| {
    file { "/etc/cups/ppd/${printer}.ppd":
      ensure  => 'file',
      require => Package['cups'],
      owner   => 'root',
      group   => $cups_group,
      mode    => '0644',
      notify  => Service['cupsd'],
      source  => "puppet:///modules/${module_name}/${printer}.ppd",
    }
  }
}
