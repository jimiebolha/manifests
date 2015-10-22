class user::admins{
	group { 'staff':
		ensure => 'present',
	}
	user{ 'admin':
		ensure	=> 'present',
		groups	=> 'staff',
		shell	=> '/bin/false',
		require	=> Group['staff'],
	}
}
