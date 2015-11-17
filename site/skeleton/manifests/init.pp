class skelton {
  file { '/etc/skel':
    ensure => directory,
  }
  file { '/etc/skel/.bashrc':
    ensure => file,
    source => 'puppet:///modules/classroom-control-vf/.bashrc',
  }
}
