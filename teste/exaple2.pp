file {'/tmp/teste2.txt':
	ensure	=> present,
	content	=> "Olá!\n",
}
notify {'mensagem':
	require	=> File['/tmp/teste2.txt'],
	message	=> 'O arquivo teste1.txt foi criado',
}
