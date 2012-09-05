-module(rudy).
-export([init/1,handler/1,request/1,reply/1, start/1, stop/0]).

start(Port) ->
    register(rudy, spawn(fun() ->
				 init(Port) end)).

stop() ->
    exit(whereis(rudy), "time to die").

init(Port) ->
    Opt = [list, {active, false}, {reuseaddr, true}],
    case gen_tcp:listen(Port, Opt) of         % opens a listening socket
	{ok, Listen} ->
	    %spawn_many(3,Listen),
	    handler(Listen),
	    gen_tcp:close(Listen),            % close the socket
	    ok;
	{error, Error} -> error
    end.

handler(Listen) ->
    case gen_tcp:accept(Listen) of            % listen to the socket
	{ok, Client} ->                       
	    request(Client),                  
	    gen_tcp:close(Client),
	    handler(Listen);
	{error, Error} -> error
    end.

request(Client) ->
    Recv = gen_tcp:recv(Client, 0),
    case Recv of
	{ok, Str} ->
	    Request = http:parse_request(Str),
	    Response = reply(Request),
	    gen_tcp:send(Client, Response);
	{error, Error} ->
	    io:format("rudy: error: ~w~n", [Error])
    end,
    gen_tcp:close(Client).

reply({{get, URI, _}, _, _}) ->
    timer:sleep(40),
    http:ok("hello you").

spawn_many(0, Listen)-> ok;
spawn_many(N, Listen)->
    spawn(rudy,handler,[Listen]),
    spawn_many(N - 1, Listen).
