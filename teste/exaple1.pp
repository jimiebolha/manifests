file {'/tmp/teste1.txt':
	ensure	=> present,
	content	=> "Olá!\n",
	before	=> Notify['mensagem'],
}
notify {'mensagem':
	message	=> 'O arquivo teste1.txt foi criado',
}
