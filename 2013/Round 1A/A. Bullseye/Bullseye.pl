% Google Code Jam
% Round 1A 2013
% A. Bullseye
% https://code.google.com/codejam/contest/2418487/dashboard#s=p0
%
% Binary search solution in B-Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% B-Prolog 8.0#1 - http://www.probp.com/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | bp -g "['Bullseye.pl'],main,halt" -l | tail -n +5 > out-file

paint(R, N, Paint) :-
    Paint is 2*R*N + 2*N*N - N.

find_max(_R, _T, N, N, N).
find_max(R, T, Lo, Hi, N) :-
    Lo < Hi,
    Mid is 1 + (Lo + Hi) // 2,
    paint(R, Mid, Paint),
    ( Paint =< T ->
        find_max(R, T, Mid, Hi, N)
    ;
        Mid1 is Mid - 1,
        find_max(R, T, Lo, Mid1, N)
    ).
    
do_case(Case_num, R, T) :-
    find_max(R, T, 0, T, N),
    format("Case #~w: ~w\n", [Case_num, N]).

main :-
    read([C]),
    foreach(Case_num in 1..C, [R, T], (
            read([R, T]),
            do_case(Case_num, R, T) 
        )).
