-module(client).
-export([client/0]).


client() ->
    {ok, Socket} = gen_tcp:connect("127.0.0.1", 5678, 
                                 [binary, {packet, 0}]),
    gen_tcp:send(Socket, "<TRX><CRD><PAN>54678933232433</PAN><EXP>1219</EXP></CRD><CTI>qqqqqqqqwwwwwwwwwwwwwwwweeeeeeeeeeerrrrrrrrrrrrrrtttttttttttttyyyyyyyyyyyyyyuuuuuuuuuuuuiiiiiiiiiiiiiiiiiiioooooooooooooooooooooppppppppppppaaaaaaaaaaaassssssssssddddddddddd</CTI></TRX>"),
	io:format("~nafter send").
	%{ok, Bin} = do_recv(Socket, []),
	%io:format("~n>>>~p",[Bin]).
	%gen_tcp:close(Socket).
		
		
%do_recv(Socket, AllBytes) ->
%    case gen_tcp:recv(Socket, 0) of
%        {ok, Chunk} ->
%		io:format("~nchunk"),
 %           do_recv(Socket, [AllBytes|Chunk]);
 %       {error, closed} ->
 %           {ok, list_to_binary(AllBytes)};
%		_ -> io:format("~nother")
%    end.