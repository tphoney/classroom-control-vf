class motd {
  exec { 'something':
    command => "cowsay 'Welcome to ${::fqdn}!' > /etc/motd"
    creates => '/etc/motd',
  }
}
