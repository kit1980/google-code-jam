% Google Code Jam
% Round 1A 2008
% A. Minimum Scalar Product
% https://code.google.com/codejam/contest/dashboard?c=32016#s=p0
%
% Algorithmic solutuion in ECLiPSe Prolog, not really a constraint programming.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b MinimumScalarProduct.ecl -e main > out-file

:- lib(ic). % for scalar product

min_product(Xs0, Ys0, Product) :-
    number_sort(0, =<, Xs0, Xs),
    number_sort(0, >=, Ys0, Ys),
    Product #= Xs * Ys.

do_case(Case_num, Xs, Ys) :-
    min_product(Xs, Ys, Product),
    printf("Case #%w: %w\n", [Case_num, Product]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([_N]),
        read(Xs),
        read(Ys),
        do_case(Case_num, Xs, Ys) ).
