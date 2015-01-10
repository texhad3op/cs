-module(server).
-include("parameter_names.hrl").
-export([start/1]).
-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false}, {reuseaddr, true}]).

start(Conf)->
    {ok, LSocket} = gen_tcp:listen(8080, ?TCP_OPTIONS),
	io:format("~p", [gen_tcp:accept(LSocket)]),
	spawn(fun() -> process(LSocket) end).
%configuration:get_parameter(?LISTENER_PORT, Conf)



% Call echo:listen(Port) to start the service.
listen(Port) ->


    {ok, Listen} = gen_tcp:listen(8089, [binary, {packet, 0},
					 {reuseaddr, true},
					 {active, true}]),
	error_logger:error_msg("waiting for a socket connection...").

	%spawn(fun() -> process(Listen) end).

process(LSocket)->
	ok.
	%{ok, Socket} = gen_tcp:accept(Listen).
%	io:format("~p", [gen_tcp:accept(Listen)]).
%	spawn(fun() -> processa(Listen) end),
%	{ok, Socket} = gen_tcp:accept(Listen),
%	try 
%		socket_processor(Socket).
%	catch
%		_:_ -> io:format("Was Error!!!")
%	end.