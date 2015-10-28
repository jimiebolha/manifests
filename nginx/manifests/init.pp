class nginx {
  case $::osfamily {
	'debian','RedHat': {
	 $package = 'nginx'
	 $owner	  = 'root'
	 $group	  = 'root'
	 $docroot = '/var/www'
	 $confdir = '/etc/nginx'
	 $logdir  =  '/var/log/nginx'
	}
	'windows': {
	$package  = 'nginx-service'
	$owner    = 'Administrator'
	$group    = 'Administrator'
	$docroot  = 'C:\ProgramData\nginx\html'
	$confdir  = 'C:\ProgramData\nginx'
	}
	default  :{
	fail("Module ${module_name} is not suported on ${::osfamily}")
	}
    }
  File {
	owner	=> $owner,
	group	=> $group,
	mode	=> '0644',
	}

  package { $package:
    ensure  => 'installed',
  }
  file { $docroot:
      	ensure  => 'directory',
      	require => Package[$package],
      }
  file {'index.html':
   	 ensure  => 'file',
    	 path    =>  "${docroot}/index.html",
	 content =>  template('nginx/index.html.erb'),
    	 require => File[$docroot],
    }
 file{'default.conf':
   	path	 => "${confdir}/conf.d/default.conf",
	ensure	 => 'file',
   	#source  => "puppet:///modules/nginx/default-${::kernel}.conf",
	content  => template('nginx/default.conf.erb'),
   	require  => Package['nginx'],
   	notify   => Service['nginx'],
}
 file{'nginx.conf':
   	path	=> "${confdir}/nginx.conf",
	ensure	=> 'file',
   	#source => "puppet:///modules/nginx/${::osfamily}.conf",
	content => template('nginx/nginx.conf.erb'),
   	require => Package[$package],
}
 service {'nginx':
	ensure	=> running,
	enable	=> true,
	hasrestart => true,
	hasstatus  => true,
	subscribe  => File['nginx.conf'],
	}
}
