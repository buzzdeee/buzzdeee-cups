# private class, do not use directly
# takes care about the service
class cups::client::service (
  $service_provider,
  $services,
){

  $services = [ 'cupsd.service', 'cups.path', 'cups.service', 'cups.socket' ]

  service { $services:
    ensure => 'stopped',
    enable => 'false',
    provider => $service_provider,
  }

}
