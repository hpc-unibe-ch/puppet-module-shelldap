# == Class shelldap::service
#
# This class is meant to be called from shelldap
# It ensure the service is running
#
class shelldap::service {

  service { $shelldap::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
