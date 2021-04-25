-module(toppage_h).

-export([init/2]).

init(Req0, Opts) ->
    io:fwrite("Request HIT!~n", []),
	Req = cowboy_req:reply(200, #{
		<<"content-type">> => <<"text/plain">>
	}, <<"Hello world!">>, Req0),
	{ok, Req, Opts}.