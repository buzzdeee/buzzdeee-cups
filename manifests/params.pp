# private class, do not use directly
# the parameters that drive this module

class cups::params {
  case $::osfamily {
    'OpenBSD': {
      $packages = [ 'cups', 'hpcups', ]
      $service_provider = undef
      $services = [ 'cupsd' ]
    }
    'Suse': {
      $packages = [ 'cups', 'cups-libs', 'cups-client', ]
      $service_provider = 'systemd'
      $services = [ 'cupsd.service', 'cups.path', 'cups.service', 'cups.socket' ]
    }
  }

  $packages_ensure = 'installed'

  $is_cups_client = 'false'
  $is_cups_server = 'false'
  $remote_cups_server = 'cups'

}
