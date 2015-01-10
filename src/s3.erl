-module(s3).
-export([start/0, start_servers/1]).

start()->
    case gen_tcp:listen(5678,[{active, false},{packet,2}]) of
        {ok, ListenSock} ->
            start_servers(ListenSock),
            {ok, Port} = inet:port(ListenSock);
        {error,Reason} ->
            {error,Reason}
    end.	

start_servers(ListenSock) ->
    case gen_tcp:accept(ListenSock) of
        {ok,Socket} ->
            spawn(?MODULE, start_servers, [ListenSock]),	
            loop(Socket);

        Other ->
            io:format("accept returned ~w - goodbye!~n",[Other])
    end.


loop(Socket) ->
    inet:setopts(Socket,[{active,once}]),
    receive
        {tcp,Socket,Data} ->
			io:format("~nGot:~p",[Data]),
            Answer = process(Data),
            gen_tcp:send(Socket,Answer),
            loop(Socket);
        {tcp_closed,Socket} ->
            io:format("Socket ~w closed [~w]~n",[Socket,self()]),
            ok
    end.

process(Data)-> Data++"Answ".	


