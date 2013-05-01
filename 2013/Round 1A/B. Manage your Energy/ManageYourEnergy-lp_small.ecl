% Google Code Jam
% Round 1A 2013
% B. Manage your Energy
% https://code.google.com/codejam/contest/2418487/dashboard#s=p1
%
% (Integer) linear programming solution in ECLiPSe Prolog.
% Works for the small input only because of imprecise representation of large integers by floating-point numbers.
% Only several cases from the large input fail (after removing all integer constraints).
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b ManageYourEnergy-lp_small.ecl -e main > out-file

:- set_stream(log_output, null).
:- lib(eplex).

model(E, R, Vs, Js, S) :-
    length(Vs, N),
    dim(Es, [N]),
    dim(Js, [N]),
    Es[1] $= E,
    ( foreacharg(Ei, Es), foreacharg(Ji, Js), param(E) do
        Ei $>= 0,
        Ei $=< E,
        integers(Ei), % not necessary - forced by optimality, but it's not obvious
        Ei - Ji $>= 0,
        Ji $>= 0,
        integers(Ji) % not necessary - forced by optimality, but it's not obvious
    ),
    ( for(I, 2, N), param(Es, Js, R) do
        Es[I] $=< Es[I - 1] - Js[I - 1] + R ),
    integers(S), % to get integer from eplex_var_get(S, typed_solution, Sval)
    flatten_array(Js, Jslist),
    S $= Vs * Jslist.

find(S, Sval) :-
    eplex_solver_setup(max(S)),
    eplex_solve(_),
    eplex_var_get(S, typed_solution, Sval),
    eplex_cleanup.

do_case(Case_num, E, R, Vs) :-
    model(E, R, Vs, _Js, S),
    find(S, Sval),
    printf("Case #%w: %w\n", [Case_num, Sval]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([E, R, _N]),
        read(Vs),
        do_case(Case_num, E, R, Vs) ).
