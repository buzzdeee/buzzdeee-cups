# private class, do not use directly
# takes care about the service
class cups::client::service (
  $service_provider,
  $services,
){

  service { $services:
    ensure   => 'stopped',
    enable   => false,
    provider => $service_provider,
  }

}
