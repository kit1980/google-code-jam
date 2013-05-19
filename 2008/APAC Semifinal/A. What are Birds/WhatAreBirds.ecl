% Google Code Jam
% APAC Semifinal 2008
% A. What are Birds?
% https://code.google.com/codejam/contest/32005/dashboard#s=p0 
%
% Constraint programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% python preprocess.py < in-file | sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' | eclipse -b WhatAreBirds.ecl -e main > out-file

:- lib(ic).

model(Infos, Limits) :-
    [BirdHMin, BirdHMax, BirdWMin, BirdWMax] :: 1..10000000,
    [NotHMin, NotHMax, NotWMin, NotWMax] :: 0..10000001,
    BirdHMin #=< BirdHMax, BirdWMin #=< BirdWMax,
    NotHMin #=< NotHMax, NotWMin #=< NotWMax,
    NotHMin #< BirdHMin, NotHMax #> BirdHMax,
    NotWMin #< BirdWMin, NotWMax #> BirdWMax,
    ( foreach([H, W, X], Infos), param(BirdHMin, BirdHMax, BirdWMin, BirdWMax, NotHMin, NotHMax, NotWMin, NotWMax) do
        ( X =:= 1 ->
            BirdHMin #=< H, BirdHMax #>= H,
            BirdWMin #=< W, BirdWMax #>= W,
            NotHMin #< H, NotHMax #> H, 
            NotWMin #< W, NotWMax #> W                
        ;
            (BirdHMin #> H and NotHMin #>= H) or (BirdHMax #< H and NotHMax #=< H) or 
            (BirdWMin #> W and NotWMin #>= W) or (BirdWMax #< W and NotWMax #=< W)
        )
    ),
    Limits = [BirdHMin, BirdHMax, BirdWMin, BirdWMax, NotHMin, NotHMax, NotWMin, NotWMax].

query_bird(Limits, H, W, Result) :-
    Limits = [BirdHMin, BirdHMax, BirdWMin, BirdWMax, _NotHMin, _NotHMax, _NotWMin, _NotWMax],
    ( H #>= BirdHMin, H #=< BirdHMax, W #>= BirdWMin, W #=< BirdWMax, labeling(Limits) ->
        Result = 1
    ;
        Result = 0
    ).

query_not(Limits, H, W, Result) :-
    Limits = [_BirdHMin, _BirdHMax, _BirdWMin, _BirdWMax, NotHMin, NotHMax, NotWMin, NotWMax],
    ( H #=< NotHMin or H #>= NotHMax or W #=< NotWMin or W #>= NotWMax, labeling(Limits) ->
        Result = 1
    ;
        Result = 0
    ).

result(1, 0, "BIRD").
result(0, 1, "NOT BIRD").
result(0, 0, "UNKNOWN").
result(1, 1, "UNKNOWN").
query(Limits, [H, W], Result) :-
    % Use findall to fail query_bird/4 and query_not/4 and undo possible Limits changes.
    findall(ResultBird, query_bird(Limits, H, W, ResultBird), [ResultBird]),
    findall(ResultNot, query_not(Limits, H, W, ResultNot), [ResultNot]),
    result(ResultBird, ResultNot, Result).

do_case(Case_num, Infos, Queries) :-
    model(Infos, Limits),
    printf("Case #%w:\n", [Case_num]),
    ( foreach(Query, Queries), param(Limits) do
        query(Limits, Query, Result), 
        writeln(Result) ).

main :-
    read([C]),
    ( for(Case_num, 1, C) do
        read([N]),
        ( for(_I, 1, N), foreach(Info, Infos) do
            read(Info) ),
        read([M]),
        ( for(_I, 1, M), foreach(Query, Queries) do
            read(Query) ),
        do_case(Case_num, Infos, Queries) ).
