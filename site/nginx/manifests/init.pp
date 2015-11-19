class nginx {

  case $::operatingsystem {
    'RedHat': {
      $http_dir = '/var/www'
      $nginx_base_dir = '/etc/nginx'
      $nginx_packagename = 'nginx'
    }
    'windows': {
      $http_dir = 'C:/ProgramData/nginx/html'
      $nginx_base_dir = 'C:/ProgramData/nginx'
      $nginx_packagename = 'nginx-service'
    }
    # default assumes WHO CARES 
    faik ( "OS NOT SUPPORTED" )
  }
  
  package { "${nginx_package_dir}":
    ensure => present,
  }
  
  file { "${nginx_base_dir}/nginx.conf":
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file { "${nginx_base_dir}/conf.d/default.conf":
    ensure => file,
    source => 'puppet:///modules/nginx/${::osfamily}.conf",
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { "${http_dir}":
    ensure => directory
  }
  file { "${http_dir}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
