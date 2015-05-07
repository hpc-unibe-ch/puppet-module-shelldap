# == Class: shelldap
#
# Full description of class shelldap here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class shelldap (
  $package_name = $shelldap::params::package_name,
  $service_name = $shelldap::params::service_name,
) inherits shelldap::params {

  # validate parameters here

  class { 'shelldap::install': } ->
  class { 'shelldap::config': } ~>
  class { 'shelldap::service': } ->
  Class['shelldap']
}
