% Google Code Jam
% Round 1B 2013
% A. Osmos
% https://code.google.com/codejam/contest/2434486/dashboard#s=p0
%
% Planinng-based solution in B-Prolog.
% 
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% B-Prolog 8.0#1 - http://www.probp.com/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | bp -g "cl('Osmos.pl'),main,halt" -l | tail -n +7 > out-file

final([_, []]).

action([Armin, Others], [NewArmin, Rest], absorb, 0) :-
    Others = [Min | Rest],
    Armin > Min,
    NewArmin is Armin + Min.

action([Armin, Others], [Armin, NewOthers], remove, 1) :-
    Others = [Min | _Rest],
    Armin =< Min,
    append(NewOthers, [_], Others).

action([Armin, Others], [Armin, NewOthers], add, 1) :-
    Others = [Min | _Rest],
    Armin =< Min,
    NewItem is Armin - 1,
    NewOthers = [NewItem | Others].

do_case(Case_num, Armin, Others) :-
    length(Others, Limit),
    sort(=<, Others, SortedOthers),
    bp_best_plan_downward([Armin, SortedOthers], Limit, _Plan, Cost),
    format("Case #~w: ~w\n", [Case_num, Cost]).
    
main :-
    read([T]),
    foreach(Case_num in 1..T, [Armin, _N, Others], (
            read([Armin, _N]),
            read(Others),
            do_case(Case_num, Armin, Others)
        )).
