-module(c1).
-export([start/0]).

start() ->
    {ok,Sock} = gen_tcp:connect("localhost",5678,[{active,false},
                                                    {packet,2}]),
    gen_tcp:send(Sock,Message),
    A = gen_tcp:recv(Sock,0),
    gen_tcp:close(Sock),
    A.