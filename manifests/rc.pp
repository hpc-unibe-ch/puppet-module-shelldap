# == Define Resource Type: shelldap::rc
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
# [*server*]
#   Required. The LDAP server to connect to. This can be a hostname, IP address, or a URI.
#
# [*binddn*]
#   The full dn of a user to authenticate as. If not specified, defaults to an anonymous bind. You will be prompted for a password.
#
# [*bindpass*]
#   The password to use to bind with given binddn. CAUTION! If you have turned on reporting diffs on your puppetmaster
#   this password is carried out in CLEARTEXT within the reports!
#
# [*basedn*]
#   The directory ’root’ of your LDAP server. If omitted, shelldap will try and ask the server for a sane default.
#
# [*sasl*]
#   A space separated list of SASL mechanisms.  Requires the Authen::SASL module.
#
# [*tls*]
#   (true/false) Enables TLS over what would normally be an insecure connection.  Requires server side support. Defaults to undef.
#
# [*tls_cacert*]
#   Specify CA Certificate to trust.
#
# [*tls_cert*]
#   The TLS client certificate.
#
# [*tls_key*]
#   The TLS client key.  Not specifying a key will connect via TLS without key verification.
#
# [*cacheage*]
#   Set the time to cache directory lookups in seconds.
#
# [*timeout*]
#   Set the maximum time an LDAP operation can take before it is cancelled.
#
# [*targetdir*]
#   Absolute directory where the .shelldap.rc file should be generetaed. Defaults to root's homedir.
#
define shelldap::rc(
  $server     = undef,
  $binddn     = undef,
  $bindpass   = undef,
  $basedn     = undef,
  $sasl       = undef,
  $tls        = undef,
  $tls_cacert = undef,
  $tls_cert   = undef,
  $tls_key    = undef,
  $cacheage   = undef,
  $timeout    = undef,
  $targetdir  = $::shelldap::params::targetdir
) {

  # validate parameters here
  if ! $server {
    fail('At least a server is required.')
  } else {
    validate_string($server)
  }

  if $tls {
    validate_bool($tls)
  }

  if $cacheage {
    validate_integer($cacheage)
  }

  if $timeout {
    validate_integer($cacheage)
  }

  validate_absolute_path($targetdir)

  file { "${targetdir}/.shelldap.rc":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template('shelldap/shelldap.rc.erb'),
  }
}

