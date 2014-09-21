% Google Code Jam 
% Round 2 2008
% B. Triangle Areas
% https://code.google.com/codejam/contest/32001/dashboard#s=p1
%
% Constraint programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b TriangleAreas.ecl -e main > out-file

:- lib(ic).

model(N, M, A, [X2, Y2, X3, Y3]) :-
    [X2, X3] :: 0..N,
    [Y2, Y3] :: 0..M,
    A #= abs(X2 * Y3 - X3 * Y2).

do_case(Case_num, N, M, A) :-
    printf("Case #%w: ", [Case_num]),
    ( model(N, M, A, Points), labeling(Points) ->
        printf("0 0 %w %w %w %w", Points)
    ; 
        write("IMPOSSIBLE") 
    ),
    nl.

main :-
    read([C]), 
    ( for(Case_num, 1, C) do 
        read([N, M, A]),
        do_case(Case_num, N, M, A) ).
