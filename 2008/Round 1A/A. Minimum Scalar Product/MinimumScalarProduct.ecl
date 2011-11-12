% Google Code Jam
% Round 1A 2008
% A. Minimum Scalar Product
% https://code.google.com/codejam/contest/dashboard?c=32016#s=p0
%
% Algorithmic solutuion, not really a constraint programming.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% Language: ECLiPSe Prolog (http://eclipseclp.org/)
% Tested with ECLiPSe Version 6.0 #188
% Usage: eclipse -b MinimumScalarProduct.ecl -e main < in-file > out-file

:- lib(ic).
:- lib(ic_global). % for sorted/2
:- lib(util). % for read_line/1

model(Xs0, Ys0, Scalar_product) :-
    sorted(Xs0, Xs),
    sorted(Ys0, Ys_reverse), reverse(Ys_reverse, Ys),
    Scalar_product #= Xs * Ys.

do_case(Case_num, Xs_str, Ys_str) :-
    split_string(Xs_str, " ", "", X_strs),
    ( foreach(X_str, X_strs), foreach(X, Xs) do
        number_string(X, X_str) ),
    split_string(Ys_str, " ", "", Y_strs),
    ( foreach(Y_str, Y_strs), foreach(Y, Ys) do
        number_string(Y, Y_str) ),
    model(Xs, Ys, Scalar_product),
    print_case(Case_num, Scalar_product).
    
print_case(Case_num, Scalar_product) :-
    printf("Case #%w: %w\n", [Case_num, Scalar_product]).

main :-
    read_line(T_str),
    number_string(T, T_str),
    ( count(K, 1, T) do
        read_line(_),
        read_line(Xs_str),
        read_line(Ys_str),
        do_case(K, Xs_str, Ys_str) ).
