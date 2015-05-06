# private class, do not use directly
# the parameters that drive this module

class cups::params {
  case $::osfamily {
    'OpenBSD': {
      $packages = [ 'cups', 'hpcups', ]
      $service_provider = 'openbsd'
      $services = [ 'cupsd' ]
      $cups_user = '_cups'
      $cups_group = '_cups'
    }
    'Suse': {
      $packages = [ 'cups', 'cups-libs', 'cups-client', ]
      $service_provider = 'systemd'
      $services = [ 'cupsd.service', 'cups.path', 'cups.service', 'cups.socket' ]
      $cups_user = 'root'
      $cups_group = 'lp'
    }
  }

  $packages_ensure = 'installed'

  $is_cups_client = 'false'
  $is_cups_server = 'false'
  $remote_cups_server = 'cups'

}
