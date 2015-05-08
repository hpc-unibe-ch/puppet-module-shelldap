# == Class shelldap::install
#
class shelldap::install {
  package { $shelldap::package_name:
    ensure => present,
  }
}
