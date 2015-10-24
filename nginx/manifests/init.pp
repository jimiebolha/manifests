class nginx {

  $var_dir = '/var/www/'
  $nginx_dir = '/etc/nginx'

  File {
	owner	=> 'root',
	group	=> 'root',
	mode	=> '0644',
	}
  package { 'nginx':
    ensure  => 'installed',
  }
  file { $var_dir:
      	ensure  => 'directory',
      	require => Package['nginx'],
      }
  file {'index.html':
   	 ensure  => 'file',
    	 path    =>  "${var_dir}/index.html",
    	 source  =>  'puppet:///modules/nginx/index.html',
    	 require => File[$var_dir],
    }
 file{'default.conf':
   	path	 => "${nginx_dir}/conf.d/default.conf",
   	source 	 => 'puppet:///modules/nginx/default.conf',
   	require  => Package['nginx'],
   	notify   => Service['nginx'],
}
 file{'nginx.conf':
   	path	=> "${nginx_dir}/nginx.conf",
   	source  => 'puppet:///modules/nginx/nginx.conf',
   	require => Package['nginx'],
}
 service {'nginx':
	ensure	=> running,
	enable	=> true,
	hasrestart => true,
	hasstatus  => true,
	subscribe  => File['nginx.conf'],
	}
}
