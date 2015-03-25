# == Class: cups
#
# Full description of class cups here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'cups':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class cups (
  $packages           = $cups::params::packages,
  $packages_ensure    = $cups::params::packages_ensure,
  $is_cups_client     = $cups::params::is_cups_client,
  $is_cups_server     = $cups::params::is_cups_server,
  $remote_cups_server = $cups::params::remote_cups_server,
  $service_provider   = $cups::params::service_provider,
  $services           = $cups::params::services,
) inherits cups::params {

  class { 'cups::install':
    packages_ensure => $packages_ensure,
    packages        => $packages,
  }

  if $is_cups_client {
    class { 'cups::client::config':
      remote_cups_server => $remote_cups_server,
    }

    class { 'cups::client::service':
      service_provider => $service_provider,
      services         => $services,
    }

    Class['cups::install'] ->
    Class['cups::client::config'] ~>
    Class['cups::client::service']
  }
  if $is_cups_server {
    Class['cups::install'] ->
    Class['cups::server::config'] ~>
    Class['cups::server::service']

    Class['cups::install'] ->
    Class['cups::server::config'] ~>
    Class['cups::server::service']
  }
}
