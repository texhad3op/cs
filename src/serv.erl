-module(serv).
-export([server/0]).

server() ->
    {ok, Listen} = gen_tcp:listen(5678, [binary, {packet, 0}, 
                                        {active, false}]),
	wait_connect(Listen).									


wait_connect(Listen)->
    {ok, Socket} = gen_tcp:accept(Listen),
	io:format("~naccepted"),
	%spawn(fun()->wait_connect(Listen) end),
    {ok, Bin} = do_recv(Socket, []),
    io:format("~n2:>>>~p",[Bin]).
	%gen_tcp:send(Socket, "<TRX><CRD>456</CRD></TRX>").
	%gen_tcp:close(Socket).
	
do_recv(Socket, AllBytes) ->
    case gen_tcp:recv(Socket, 0) of
        {ok, Chunk} ->
            do_recv(Socket, [AllBytes|Chunk]);
        {error, closed} ->
            {ok, list_to_binary(AllBytes)}
    end.	