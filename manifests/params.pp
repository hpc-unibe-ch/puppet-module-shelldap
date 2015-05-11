# == Class shelldap::params
#
# This class is meant to be called from shelldap.
# It sets variables according to platform
#
class shelldap::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'shelldap'
      $service_name = 'shelldap'
    }
    'RedHat', 'Amazon': {
      $package_name = 'shelldap'
      $service_name = 'shelldap'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

