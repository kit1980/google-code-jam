% Google Code Jam
% Round 2 2012
% C. Mountain View
% https://code.google.com/codejam/contest/1842485/dashboard#s=p2
%
% Straightforward integer linear programming solution in ECLiPSe Prolog.
% Works for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b MountainView-lp_small.ecl -e main > out-file

:- set_stream(log_output, null). 
:- set_stream(warning_output, null). 

:- lib(eplex).

list_array(L, A) :-
    length(L, N), dim(A, [N]),
    ( foreach(Li, L), foreacharg(Li, A) do true ), !.

model(Xs, Ys) :-
    dim(Xs, [Nm1]),
    N is Nm1 + 1,
    dim(Ys, [N]),
    ( foreacharg(Yi, Ys) do
        integers(Yi),
        Yi $:: 0..1000000000 ),
    
    ( for(I, 1, N - 1), param(Xs, Ys, N) do
        ( for(J, I + 1, Xs[I] - 1), param(I, Xs, Ys) do
            (Xs[I] - I) * (Ys[J] - Ys[I]) + 1 $=< (Ys[Xs[I]] - Ys[I]) * (J - I) ),
        ( for(J, Xs[I] + 1, N), param(I, Xs, Ys) do
            (Xs[I] - I) * (Ys[J] - Ys[I]) $=< (Ys[Xs[I]] - Ys[I]) * (J - I) ) ).
        
find :-
    eplex_solver_setup(min(0)),
    eplex_solve(_).

do_case(Case_num, Xs) :-
    model(Xs, Ys),
    printf("Case #%w: ", [Case_num]),
    ( find ->
        ( foreacharg(Yi, Ys) do
            eplex_var_get(Yi, typed_solution, YVal),
            printf("%w ", [YVal]) )
    ;
        write("Impossible")
    ),
    nl,
    eplex_cleanup.

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([_N]),
        read(Xs_list),
        list_array(Xs_list, Xs),
        do_case(Case_num, Xs) ).
