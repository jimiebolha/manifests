class user {
	user { 'fundamentals':
	ensure		=> present,
	password	=> 'puppetlabs',
#	groups		=> ['Users'], 
	}
}
