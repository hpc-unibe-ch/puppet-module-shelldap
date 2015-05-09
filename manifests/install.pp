# == Class shelldap::install
#
# This class is called from shelldap for installation.
#
class shelldap::install {
  package { $::shelldap::package_name:
    ensure => present,
  }
}
