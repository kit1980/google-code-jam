% Google Code Jam 
% Round 2 2008
% C. Star Wars
% https://code.google.com/codejam/contest/32001/dashboard#s=p2
%
% Linear programming colution in ECLiPse Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b StarWars-lp.ecl -e main > out-file

:- set_stream(log_output, error).
:- lib(eplex).

model(Xs, Ys, Zs, Ps, X, Y, Z, P) :-
    P $>= 0,
    ( foreach(Xi, Xs), foreach(Yi, Ys), foreach(Zi, Zs), foreach(Pi, Ps), 
        param(X, Y, Z, P) do 
        + (Xi - X) + (Yi - Y) + (Zi - Z) $=< Pi * P,
        + (Xi - X) + (Yi - Y) - (Zi - Z) $=< Pi * P,
        + (Xi - X) - (Yi - Y) + (Zi - Z) $=< Pi * P,
        + (Xi - X) - (Yi - Y) - (Zi - Z) $=< Pi * P,
        - (Xi - X) + (Yi - Y) + (Zi - Z) $=< Pi * P,
        - (Xi - X) + (Yi - Y) - (Zi - Z) $=< Pi * P,
        - (Xi - X) - (Yi - Y) + (Zi - Z) $=< Pi * P,
        - (Xi - X) - (Yi - Y) - (Zi - Z) $=< Pi * P ).

find(P, Pval) :-
    eplex_solver_setup(min(P)),
    eplex_solve(_),
    eplex_var_get(P, typed_solution, Pval),
    eplex_cleanup.

do_case(Case_num, Xs, Ys, Zs, Ps) :-
    model(Xs, Ys, Zs, Ps, _X, _Y, _Z, P),
    find(P, Pval),
    printf("Case #%w: %w\n", [Case_num, Pval]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do 
        read([N]),
        ( for(_I, 1, N), foreach(Xi, Xs), foreach(Yi, Ys), foreach(Zi, Zs), foreach(Pi, Ps) do 
            read([Xi, Yi, Zi, Pi]) ),
        do_case(Case_num, Xs, Ys, Zs, Ps) ).
