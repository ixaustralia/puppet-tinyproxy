# Class: tinyproxy
# ===========================
#
# Full description of class tinyproxy here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'tinyproxy':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class tinyproxy (
  Boolean $use_epel,
  String  $package_ensure,

  Enum['file', 'absent'] $config_ensure,
  Integer $port,
  Optional[String] $listen,
  Optional[String] $bind,
  Optional[Boolean] $bind_same,
  Integer $timeout,
  Optional[Hash[Integer, String]] $error_files,
  String $default_error_file,
  Optional[String] $stat_host,
  String $stat_file,
  Optional[String] $log_file,
  Boolean $use_syslog,
  Integer $max_clients,
  Integer $min_spare_servers,
  Integer $max_spare_servers,
  Integer $start_servers,
  Integer $max_requests_per_child,
  Enum['Critical', 'Error', 'Warning', 'Notice', 'Connect', 'Info'] $log_level,
  Variant[Integer, Array[Integer]] $connect_port,

  Enum['running','stopped'] $service_ensure,
  Boolean                   $service_enable,
){

  class { 'tinyproxy::install':
    use_epel       => $use_epel,
    package_ensure => $package_ensure,
  } ->

  class { 'tinyproxy::config':
    config_ensure          => $config_ensure,
    port                   => $port,
    listen                 => $listen,
    bind                   => $bind,
    bind_same              => $bind_same,
    timeout                => $timeout,
    error_files            => $error_files,
    default_error_file     => $default_error_file,
    stat_host              => $stat_host,
    stat_file              => $stat_file,
    log_file               => $log_file,
    use_syslog             => $use_syslog,
    max_clients            => $max_clients,
    min_spare_servers      => $min_spare_servers,
    max_spare_servers      => $max_spare_servers,
    start_servers          => $start_servers,
    max_requests_per_child => $max_requests_per_child,
    log_level              => $log_level,
    connect_port           => $connect_port,
  } ~>

  class { 'tinyproxy::service':
    service_ensure => $service_ensure,
    service_enable => $service_enable,
  }

}
