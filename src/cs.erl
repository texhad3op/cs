-module(cs).
-export([start/0, t/0]).

t()->
%L = [	{connector_name, isoconec},	{listen_port, 2349},	{provider_port, 14356}].
{ok,[L]} = file:consult("config.properties"),
dict:from_list(L).


start()->
	Conf = configuration:read_configuration(),
	error_logger:info_msg("Starting connector..."),
	error_logger:info_msg("with parameters:"),	
	configuration:print_configuration(Conf),
	server:start(Conf).


