define nginx::vhosts (
  $port = '80',
  $docroot = '${::nginx::http_dir}/vhost${title}",
  $servername = $title,
) {
  host { $title:
    ip => $::ipaddress,
  }
  file { "nginx-vhost-${title}":
    ensure => file,
    path => "${nginx::confdir}/conf.d/${title}.conf",
    content => template('nginx/vhost.conf.erb'),
    notify => Service['nginx'],
  }
  file { $docroot:
    ensure => directory,
    before => File["nginx-vhost-${title}"],
  }
  file { "${docroot}/index.html":
    ensure => file,
    content => template('nginx/index.html.erb'),
  }
}
