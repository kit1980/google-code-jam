% Google Code Jam 
% Round 2 2008
% B. Triangle Areas
% https://code.google.com/codejam/contest/32001/dashboard#s=p1
%
% Constaint programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b TriangleAreas.ecl -e main > out-file

:- lib(ic).

% Triangle's area * 2
area2(X1, Y1, X2, Y2, X3, Y3, A) :- 
    A #= abs(
        X1 * Y2 - X1 * Y3 + 
        X2 * Y3 - X2 * Y1 + 
        X3 * Y1 - X3 * Y2
    ).

model(N, M, A, [X1, Y1, X2, Y2, X3, Y3]) :-
    [X1, X2, X3] :: 0..N,
    [Y1, Y2, Y3] :: 0..M,
    X1 #= 0, Y1 #= 0, % we can safely put one point in (0, 0)
    area2(X1, Y1, X2, Y2, X3, Y3, A).

do_case(Case_num, N, M, A) :-
    printf("Case #%w: ", [Case_num]),
    ( model(N, M, A, Points), labeling(Points) ->
        printf("%w %w %w %w %w %w", Points)
    ; 
        write("IMPOSSIBLE") 
    ),
    nl.

main :-
    read([C]), 
    ( for(Case_num, 1, C) do 
        read([N, M, A]),
        do_case(Case_num, N, M, A) ).
