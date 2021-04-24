%%%-------------------------------------------------------------------
%% @doc npumbrella public API
%% @end
%%%-------------------------------------------------------------------

-module(npumbrella_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    npumbrella_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
