% Google Code Jam
% World Finals 2008
% C. Mine Layer
% https://code.google.com/codejam/contest/32011/dashboard#s=p2
%
% Straightforward constraint programming solution in ECLiPSe Prolog.
% Works for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b MineLayer_small.ecl -e main > out-file

:- lib(ic).
:- lib(branch_and_bound).
:- set_stream(log_output, stderr).

model(Clues, Mines, MiddleSum) :-
    dim(Clues, [R, C]),
    dim(Mines, [R, C]),
    Mines :: 0..1,
    ( multifor([I, J], 1, [R, C]), param(R, C, Clues, Mines) do
        ( multifor([Di, Dj], -1, 1), fromto(0, Prev, Curr, S), param(I, J, R, C, Mines) do
            ( I + Di > 0, I + Di =< R, J + Dj > 0, J + Dj =< C ->
                Curr = Prev + Mines[I + Di, J + Dj]
            ;
                Curr = Prev
            )
        ),
        Clues[I, J] #= eval(S)
    ),
    ( for(J, 1, C), fromto(0, Prev, Curr, Expr), param(Mines, R) do
        Curr = Prev + Mines[R // 2 + 1, J] ),
    MiddleSum #= eval(Expr).

find(Mines, MiddleSum) :-
    Cost #= -MiddleSum,
    bb_min(search(Mines, 0, most_constrained, indomain_random, complete, []), Cost, bb_options{strategy:dichotomic}).

do_case(Case_num, Clues) :-
    model(Clues, Mines, MiddleSum),
    once find(Mines, MiddleSum),
    printf("Case #%w: %w\n", [Case_num, MiddleSum]).

main :-
    read([N]),
    ( for(Case_num, 1, N) do
        read([R, C]),
        dim(Clues, [R, C]),
        ( for(I, 1, R), param(Clues, C) do
            read(Row),
            ( for(J, 1, C), foreach(Num, Row), param(I, Clues) do
                subscript(Clues, [I, J], Num) ) ),
        do_case(Case_num, Clues) ).
