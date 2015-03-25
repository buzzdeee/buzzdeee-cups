# private class, do not use directly
# takes care about package installation
class cups::install (
  $packages,
  $packages_ensure,
) {

  package { $packages:
    ensure => $packages_ensure,
  }

}
