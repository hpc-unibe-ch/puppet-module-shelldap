#shelldap

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with shelldap](#setup)
    * [What shelldap affects](#what-shelldap-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with shelldap](#beginning-with-shelldap)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)

##Overview

This module installs and configures shelldap.

##Module Description

Shelldap is a handy shell-like interface for browsing LDAP servers and editing their content. This modules installs and configures this package.

##Setup

###What shelldap affects

The module installs the shelldap package and optionally manages configuration script that provide default options for easy invocation.

###Setup Requirements

For Red Hat and its derivates: shelldap is not available in base channels. You have
to build the rpm for yourself or use one available elsewhere. Shelldap requires
additional packages some of which are only found in EPEL. Make sure the EPEL
repository is available. The shelldap class does not handle yum repository resources.

###Beginning with shelldap

To install `shelldap` simply include the primary class:

```puppet
    include shelldap
```

If you want to maintan a configuration file for easy invocation add additionally somewhat like the following:

```puppet
    shelldap::rc { 'root-shelldap.rc':
      server => 'ldap://ldap.example.com',
      basedn => 'dc=example,dc=example.com',
    }
```
All options are listed [below](#defined-type-shelldap-rc).

##Usage

###Class: `shelldap`

The module's only class is the entry point of the module.

**Parameters within `shelldap`:**

####`package_name`

The name of the rpm package to be installed. This parameter only has to provided if package name available differs from the default. Defaults to 'shelldap'.

###Defined Type: `shelldap::rc`

This defined type manages configurations file (.shelldap.rc) to configure easy shelldap invocation by providing defaults. Parameters not provided are omitted in the resulting .shelldap.rc file.

**Parameters within `shelldap::rc`:**

####`server`

The LDAP server to connect to. This can be a hostname, IP address, or a URI. Defaults to `undef`.

####`binddn`

The full dn of a user to authenticate as. If not specified, defaults to an anonymous bind. Defaults to `undef`.

####`bindpass`

####`basedn`

The base dn to connect to. Defaults to `undef`.

####`sasl`

A space separated list of SASL mechanisms. Defaults to `undef`.

####`tls`

Enables TLS over what would normally be an insecure connection. Values can match `/^(True|False|0|1|No|Yes)$/i`. Defaults to `undef`.

####`tls_cacert`

Specify CA Certificate to trust. Value must be an absolute path to a file. Defaults to `undef`.

####`tls_cert`

The TLS client certificate. Value must be an absolute path to a file. Defaults to `undef`.

####`tls_key`

The TLS client key. Value must be an absolute path to a file. Defaults to `undef`.

####`cacheage`

Set the time to cache directory lookups in seconds. Defaults to `undef`.

####`timeout`

Set the maximum time an LDAP operation can take before it is cancelled. Defaults to `undef`.

####`targetdir`

The target directory the .shelldap.rc files is generated in. Defaults to '/root'.

##Reference

###Classes

####Public Classes

* [`shelldap`](#class-shelldap): Primary class that configures the yum repository


####Private Classes

* `shelldap::params`: Provides default values for certain parameters
* `shelldap::install`: Package installation

###Defined Types

####Public Defined Types

* `shelldap::rc`: Generates .shelldap.rc configuration files

####Private Defined Types

none

##Limitations

This module has been tested with CentOS 6 and 7 and is compatible to RHEL and its derivates with the same version.

