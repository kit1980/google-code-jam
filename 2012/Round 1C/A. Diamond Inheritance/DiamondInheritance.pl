% Google Code Jam
% Round 1C 2012
% A. Diamond Inheritance
% https://code.google.com/codejam/contest/1781488/dashboard#s=p0
%
% Backtracking/memoization solution in B-Prolog.
% 
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% B-Prolog 7.8#1 - http://www.probp.com/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | bp -g "['DiamondInheritance.pl'],main,halt" -l | tail -n +5 > out-file

:- table inherit/2.

inherit(A, B) :- 
    parent(A, B).

inherit(A, C) :-
    parent(A, B),
    inherit(B, C).

diamond(A) :- 
    parent(A, B1),
    parent(A, B2),
    B1 \= B2,
    (
        inherit(B1, C), inherit(B2, C)
    ;
        inherit(B1, B2)
    ).

do_case(Case_num) :-
    ( diamond(_) -> Result = "Yes" ; Result = "No" ),
    format("Case #~w: ~s\n", [Case_num, Result]).
    
main :-
    read([T]),
    foreach(Case_num in 1..T, [N], (
            initialize_table, abolish,
            read([N]),
            foreach(I in 1..N, [Parents, _M], (
                    read([_M|Parents]),
                    foreach(P in Parents, assert(parent(I, P)))
                )),
            do_case(Case_num)
        )).
