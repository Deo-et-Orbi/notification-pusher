%%%-------------------------------------------------------------------
%% @doc npapp public API
%% @end
%%%-------------------------------------------------------------------

-module(npapp_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    npapp_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
