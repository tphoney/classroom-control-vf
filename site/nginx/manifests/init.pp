class nginx (
  $package = $nginx::params::package,
$owner = $nginx::params::owner,
$group = $nginx::params::group,
$docroot = $nginx::params::docroot,
$confdir = $nginx::params::confdir,
$logdir = $nginx::params::logdir,
$user = $nginx::params::user,
) inherits nginx::params {

  case $::osfamily {
    'redhat': {
      $http_dir = '/var/www'
      $nginx_base_dir = '/etc/nginx'
      $nginx_packagename = 'nginx'
      notice ('WTF ITS REDHAT')
    }
    'windows': {
      $http_dir = 'C:/ProgramData/nginx/html'
      $nginx_base_dir = 'C:/ProgramData/nginx'
      $nginx_packagename = 'nginx-service'
    }
    default: {
      # default assumes WHO CARES 
      fail ( "${osfamily}: OS NOT SUPPORTED" )
    }
  }
  
  package { "${nginx_packagename}":
    ensure => present,
  }
  
  file { "${nginx_base_dir}/nginx.conf":
    ensure => file,
    source => "puppet:///modules/nginx/${::osfamily}.conf",
  }
  file { "${nginx_base_dir}/conf.d/default.conf":
    ensure => file,
    source => "puppet:///modules/nginx/default-${::kernel}.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { $http_dir:
    ensure => directory
  }
  file { "${http_dir}/index.html":
    ensure => file,
    require => Package['nginx'],
    content => template('nginx/index.html.erb'),
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
