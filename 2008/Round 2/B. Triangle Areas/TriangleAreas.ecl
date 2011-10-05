% Google Code Jam 
% Round 2 2008
% Problem B. Triangle Areas
% https://code.google.com/codejam/contest/dashboard?c=32001#s=p1
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% Language: ECLiPSe Prolog (http://eclipseclp.org/)
% Tested with ECLiPSe Version 6.0 #188
% Usage: eclipse -b TriangleAreas.ecl -e main < in-file > out-file

:- lib(ic).
:- lib(util).

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

find(Points) :-
    search(Points, 0, input_order, indomain_split, complete, []).

do_case(Case_num, Case_str) :-
    ( 
        split_string(Case_str, " ", "", [N_str, M_str, A_str]),
        number_string(N, N_str), number_string(M, M_str), number_string(A, A_str),
        model(N, M, A, Points),
        find(Points),
        print_case(Case_num, Points)
    ) ; (
            print_case(Case_num, [])
        ).

print_case(Case_num, [X1, Y1, X2, Y2, X3, Y3]) :-
    printf("Case #%d: %d %d %d %d %d %d\n", [Case_num, X1, Y1, X2, Y2, X3, Y3]).
print_case(Case_num, []) :-
    printf("Case #%d: IMPOSSIBLE\n", [Case_num]).

main :-
    read_line(C_str),
    number_string(C, C_str),
    ( count(K, 1, C) do 
        read_line(Case_str),
        do_case(K, Case_str) ).
