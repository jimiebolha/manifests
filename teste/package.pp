package {'sshd':
	ensure	=> 'present',
	enable	=> 'true',
	}
service {'sshd';
	ensure	=> 'running',
	enable	=> 'true',

}
