# private class, do not use directly
# steers the cups client configuration

class cups::client::config (
  $remote_cups_server,
) {
  file { '/etc/cups/client.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('cups/client.conf.erb'),
  }
}
