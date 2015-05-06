# private class, do not use directly
# takes care about the service
class cups::server::service (
  $service_provider,
  $services,
){

  service { $services:
    ensure   => 'running',
    enable   => true,
    provider => $service_provider,
  }

}
