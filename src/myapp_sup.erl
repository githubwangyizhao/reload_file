-module(myapp_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    MyAppServer = ?CHILD(myapp_server, worker),
    MyAppServer2 = ?CHILD(myapp_server2, worker),
    MyAppServer3 = ?CHILD(myapp_server3, worker),
    {ok, { {one_for_one, 5, 10}, [MyAppServer, MyAppServer2, MyAppServer3]} }.

