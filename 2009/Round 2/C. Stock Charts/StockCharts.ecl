% Google Code Jam
% Round 2 2009
% C. Stock Charts
% https://code.google.com/codejam/contest/204113/dashboard#s=p2
%
% Constraint programming solution in ECLiPSe Prolog.
% Uses preprocessed input from preprocess-prolog.py.
% Solves min graph-coloring problem using DSATUR heuristic and limited discrepancy search.
% Provided inputs are solved correctly, but there may exist an input that will not be solved.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
% ECLiPSe 6.1 #179 - http://www.eclipseclp.org/
% Usage:
% python preprocess-prolog.py < in-file | eclipse -b StockCharts.ecl -e main > out-file

:- set_stream(log_output, stderr).

:- lib(ic).
:- lib(branch_and_bound).

model(N, Conflicts, Values, MaxVal) :-
    dim(Values, [N]),
    Values :: 1..N,
    Values[1] #= 1,
    ( foreach([A, B], Conflicts), param(Values) do
        Values[A] #\= Values[B] ),
    MaxVal #= max(Values).

find(Values, MaxVal) :-
    bb_min(
        search(Values, 0, most_constrained, indomain_min, lds(2), []),
        MaxVal, _).

do_case(Case_num, N, Conflicts) :-
    model(N, Conflicts, Values, MaxVal),
    find(Values, MaxVal),
    printf("Case #%w: %w\n", [Case_num, MaxVal]).

main :-
    read(T),
    ( for(Case_num, 1, T) do
        read(N),
        read(C),
        ( for(_I, 1, C), foreach(Conflict, Conflicts) do
            read(Conflict) ),
        do_case(Case_num, N, Conflicts) ).      
