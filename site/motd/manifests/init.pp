class motd {
  exec { 'cowsay':
    command => "cowsay 'Welcome to ${::fqdn}!' > /etc/motd",
    creates => '/etc/motd',
    path => '/usr/bin:/usr/local/bin',
  }
}
