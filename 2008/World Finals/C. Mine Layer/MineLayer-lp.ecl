% Google Code Jam
% World Finals 2008
% C. Mine Layer
% https://code.google.com/codejam/contest/32011/dashboard#s=p2
%
% Straightforward integer linear programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.1 #179 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b MineLayer-lp.ecl -e main > out-file

:- set_stream(log_output, stderr).
:- set_stream(warning_output, stderr).
:- lib(eplex).

model(Clues, Mines, MiddleSum) :-
    dim(Clues, [R, C]),
    dim(Mines, [R, C]),
    ( foreachelem(Mine, Mines) do
        Mine $:: 0..1,
        integers(Mine) ),
    ( multifor([I, J], 1, [R, C]), param(R, C, Clues, Mines) do
        ( multifor([Di, Dj], -1, 1), fromto(0, Prev, Curr, S), param(I, J, R, C, Mines) do
            ( I + Di > 0, I + Di =< R, J + Dj > 0, J + Dj =< C ->
                Curr = Prev + Mines[I + Di, J + Dj]
            ;
                Curr = Prev
            )
        ),
        % eval(S) is not required for eplex, but would be required for ic.
        % Using $=/2 instead of =/2 for constructing S is much slower (contrary to ic).
        Clues[I, J] $= S 
    ),
    ( for(J, 1, C), fromto(0, Prev, Curr, MiddleSumExpr), param(Mines, R) do
        Curr = Prev + Mines[R // 2 + 1, J] ),
    integers(MiddleSum),
    % eval(MiddleSumExpr) is not required for eplex, but would be required for ic.
    MiddleSum $= MiddleSumExpr.

find(MiddleSum) :-
    eplex_solver_setup(max(MiddleSum)),
    eplex_solve(_),
    eplex_var_get(MiddleSum, typed_solution, MiddleSum),
    eplex_cleanup.
    
do_case(Case_num, Clues) :-
    model(Clues, _Mines, MiddleSum),
    find(MiddleSum),
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
