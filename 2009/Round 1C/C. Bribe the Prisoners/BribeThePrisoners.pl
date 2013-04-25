% Google Code Jam
% Round 1C 2009
% C. Bribe the Prisoners
% https://code.google.com/codejam/contest/189252/dashboard#s=p2 
%
% Top-down dynamic programming solution in B-Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% B-Prolog 7.8#1 - http://www.probp.com/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | bp -g "['BribeThePrisoners.pl'],main,halt" -l | tail -n +5 > out-file

:- table cost(+, +, min).

cost(A, B, 0) :- 
     \+ (ToFree :: A..B, free(ToFree)).

cost(A, B, V) :- 
    free(ToFree),
    ToFree >= A, ToFree =< B,
    Left is ToFree - 1, cost(A, Left, Vleft),
    Right is ToFree + 1, cost(Right, B, Vright),
    V is B - A + Vleft + Vright.

do_case(Case_num, P) :-
    cost(1, P, V),
    format("Case #~w: ~w\n", [Case_num, V]).
    
main :-
    read([N]),
    foreach(Case_num in 1..N, [P, Q, Free], (
                initialize_table, abolish,
                read([P, Q]),
                read(Free),
                foreach(ToFree in Free, assert(free(ToFree))),
                do_case(Case_num, P)
           )).
