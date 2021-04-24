%%%-------------------------------------------------------------------
%% @doc npumbrella public API
%% @end
%%%-------------------------------------------------------------------

-module(npumbrella_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
		{'_', [
			{"/", toppage_h, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),
    npumbrella_sup:start_link().

stop(_State) ->
    ok = cowboy:stop_listener(http).

%% internal functions
