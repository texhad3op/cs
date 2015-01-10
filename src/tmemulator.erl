-module(tmemulator).
-export([send/2]).


send(Port, Filename)->
	RequestString = getRequestString(Filename),
	io:format("~nPort:~p~nRequestString:~p",[Port, RequestString]),
	
	{ok,Sock} = gen_tcp:connect("localhost",Port,[{active,false},
                                                    {packet,2}]),
    gen_tcp:send(Sock, RequestString),
    ResponseString = gen_tcp:recv(Sock,0),
    gen_tcp:close(Sock),
    io:format("~nResponse:~p",[ResponseString]),
	
	ok.




getRequestString(Filename)->
    {ok, Device} = file:open(Filename, [read]),
    try 
		string:join(lists:reverse(get_all_lines(Device,[])),"")
    after 
		file:close(Device)
    end.

get_all_lines(Device, Acc) ->
    case io:get_line(Device, "") of
        eof  -> Acc;
        Line ->get_all_lines(Device, [re:replace(re:replace(string:strip(Line), "\n", "", [global, {return, list}]), "\t", "", [global, {return, list}])|Acc])
    end.