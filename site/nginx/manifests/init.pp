class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
  }
  file { "/var/www"
    ensure => directory
  }
  file { "/var/www/index.html"
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
