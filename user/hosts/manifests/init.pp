class hosts {
	#host { 'localhost':
	#	ensure	=> 'present',
	#	host_alias => ['testing.puppetlabs.vm'],
	#	ip	=> '127.0.0.1',
	#	target	=> '/etc/hosts/',
	#}

	host {'testing.puppetlabs.vm':
		ensure	=> present,
		ip	=> '127.0.0.1',
	 }
}
