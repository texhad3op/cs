-module(cs).
-export([start/0, t/0]).

t()->
%L = [	{connector_name, isoconec},	{listen_port, 2349},	{provider_port, 14356}].
{ok,[L]} = file:consult("config.properties"),
dict:from_list(L).


start()->
	Conf = configuration:read_configuration(),
	io:format("~nStarting connector..."),
	io:format("~nwith parameters:"),	
	configuration:print_configuration(Conf),
	start_server(Conf).
	


start_server(Conf)->ok.

