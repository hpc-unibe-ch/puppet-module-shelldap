# == Class: shelldap
#
# This module installs shelldap and optinally deploys .shell.rc files
# to the home directory of specified user(s).
#
# For Red Hat and its derivate: shelldap is not available in base channels. You have
# build the rpm for yourself or use one available elsewhere. Shelldap requires
# additional packages some of which are only found in EPEL. Make sure the EPEL
# repository is available.
#
# === Parameters
#
# [*package_name*]
#   Alternative package name if it differs from the module's default value; defaults to "shelldap"
#
class shelldap (
  $package_name = $shelldap::params::package_name,
) inherits ::shelldap::params {

  # validate parameters here
  validate_string($package_name)

  class { '::shelldap::install': } ->
  Class['::shelldap']
}
