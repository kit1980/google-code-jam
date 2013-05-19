% Google Code Jam
% Round 1B 2012
% C. Equal Sums
% https://code.google.com/codejam/contest/1836486/dashboard#s=p2
%
% Integer linear programming solution in ECLiPSe Prolog.
% Works for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b EqualSums-lp_small.ecl -e main > out-file

:- set_stream(log_output, error).
:- set_stream(warning_output, error).

:- lib(eplex).

model(Ss, As, Bs) :-
    dim(Ss, [N]),
    dim(As, [N]),
    dim(Bs, [N]),
    ( for(I, 1, N), param(As, Bs) do
        As[I] $:: 0..1,
        Bs[I] $:: 0..1,
        integers(As[I]),
        integers(Bs[I]) ),
    ( for(I, 1, N), fromto(0, PrevSumA, CurrSumA, SumA), fromto(0, PrevSumB, CurrSumB, SumB), param(Ss, As, Bs) do
        CurrSumA = PrevSumA + As[I] * Ss[I],
        CurrSumB = PrevSumB + Bs[I] * Ss[I] ),
    ( for(I, 1, N), param(As, Bs) do
        As[I] + Bs[I] $=< 1 ),
    SumA $= SumB,
    SumA $>= 1.

find :-
    eplex_solver_setup(min(0)),
    eplex_solve(_).

print_values(Ss, Xs) :-
    dim(Xs, [N]),
    ( for(I, 1, N), param(Ss, Xs) do
        Xi is Xs[I],
        eplex_var_get(Xi, typed_solution, Val),
        (Val > 0 ->
            Si is Ss[I],
            printf("%w ", [Si])
        ;
            true
        )
    ).        

do_case(Case_num, Ss) :-
    printf("Case #%w:\n", [Case_num]),
    ( model(Ss, As, Bs), find ->
        print_values(Ss, As),
        nl,
        print_values(Ss, Bs)
    ;
        write("Impossible")
    ),
    nl,
    eplex_cleanup.

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([N | Slist]),
        dim(Ss, [N]),
        ( foreach(S, Slist), foreacharg(S, Ss) do
            true ),
        do_case(Case_num, Ss) ).
