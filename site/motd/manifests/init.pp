class motd {
  exec { "cowsay 'Welcome to ${::fqdn}!' > /etc/motd":
    creates => '/etc/motd',
    path => '/usr/bin:/usr/local/bin',
  }
}
