% Google Code Jam
% Qualification Round 2013
% B. Lawnmower
% https://code.google.com/codejam/contest/2270488/dashboard#s=p1
%
% Algorithmic solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b Lawnmower.ecl -e main > out-file

check(Field) :-
    dim(Field, [R, C]),
    ( multifor([I, J], 1, [R, C]), param(Field, R, C) do
        Field[I, J] >= min([max(Field[I, 1..C]), max(Field[1..R, J])]) ).

do_case(Case_num, Field) :- 
    printf("Case #%w: ", [Case_num]),
    ( check(Field) ->
        write("YES")
    ;
        write("NO")
    ),
    nl.

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([N, M]),
        dim(Field, [N, M]),
        ( for(I, 1, N), param(Field, M) do
            read(Row),
            ( foreach(Elem, Row), for(J, 1, M), param(Field, I) do
                subscript(Field, [I, J], Elem) ) ),
        do_case(Case_num, Field) ).
