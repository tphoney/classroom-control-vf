class nginx {
  $http_dir = '/var/www'
  $nginx_dir = '/etc/nginx'

  
  package { 'nginx':
    ensure => present,
  }
  
  file { '${nginx_dir}/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file { '${nginx_dir}/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
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
