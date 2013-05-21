% Google Code Jam
% Round 1B 2012
% A. Safety in Numbers
% https://code.google.com/codejam/contest/1836486/dashboard#s=p0
%
% Linear programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b SafetyInNumbers-lp.ecl -e main > out-file

:- set_stream(log_output, stderr).

:- lib(eplex).

model(Js, Ys) :-
    sum(Js, X),
    length(Js, N),
    length(Ys, N), Ys :: 0.0..1.0, sum(Ys) $= 1.0,
    ( foreach(Ji, Js), foreach(Yi, Ys), param(X, MinScore) do
        MinScore $=< Ji + X * Yi ),
    eplex_solver_setup(max(MinScore)).
    
do_case(Case_num, Js) :-
    model(Js, Ys),
    eplex_solve(_),
    ( foreach(Yi, Ys), foreach(Mi, Ms) do
        eplex_var_get(Yi, typed_solution, Mi) ),
    eplex_cleanup,
    print_case(Case_num, Ms).
   
print_case(Case_num, Ms) :-
    printf("Case #%w: ", [Case_num]),
    ( foreach(Mi, Ms) do
        Mmi is 100 * abs(Mi), % abs to prevent -0.0
        printf("%w ", [Mmi])),
    nl.

main :-
    read([T]),
    ( for(Case_num, 1, T) do 
        read([_N | Js]),
        do_case(Case_num, Js) ).
