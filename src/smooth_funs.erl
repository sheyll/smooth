%% @doc Smooth functions functions for erlang(yes, 'functions' is twice on purpose).
%%
%% Utilities dealing with functions, like composing lists of function, partial
%% application, etc
%%
%% Add `-include_lib("smooth/include/smooth_funs.hrl").' at the top of your
%% module for more fun with smooth_funs.
-module(smooth_funs).

-compile([export_all]).

-export_type([endo/1]).

%% @doc Functions that stay in their domain.
%% The result is of the same type as the parameter.
-type endo(A) :: fun((A) -> A).

%% @doc Compose a list of functions.
%% Compose F1, F2, ... Fn and return a function F(A) = F1(F2(...(Fn(A)) ...)).
%% Same as `?compose(Funs)' macro.
-spec compose([endo(A)]) -> endo(A).
compose(Funs) ->
    fun(A) ->
            lists:foldr(fun(Fun, ANext) -> Fun(ANext) end, A, Funs)
    end.

%% @doc Compose to functions.
%% Same as `?compose(F, G)' macro.
-spec compose(fun((B)->C), fun((A)->B)) ->fun((A)->C).
compose(F,G)-> fun(A) -> F(G(A)) end.

%% @doc Partial application.
%% Same as `?curry(F, A)' macro.
-spec curry(fun((A,B) -> C), A) -> fun((B) -> C).
curry(F, A) -> fun(B) -> F(A, B) end.

%% @doc Partial application with two parameters.
%% Same as `?curry(F, A, B)' macro.
-spec curry(fun((A, B, C) -> D), A, B) -> fun((C) -> D).
curry(F, A, B) -> fun(C) -> F(A, B, C) end.

%% @doc Apply a function to the n-th element of a tuple
-spec on_nth(non_neg_integer(), fun((term())->term())) -> fun((tuple()) -> tuple()).
on_nth(N, F) ->
    fun(T) ->
            {H, [E|R]} = lists:split(N - 1, tuple_to_list(T)),
            list_to_tuple(H ++ [F(E)|R])
    end.
