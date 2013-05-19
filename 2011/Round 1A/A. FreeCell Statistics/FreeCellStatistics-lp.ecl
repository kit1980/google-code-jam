% Google Code Jam
% Round 1A 2011
% A. FreeCell Statistics
% https://code.google.com/codejam/contest/1145485/dashboard#s=p0
%
% Straightforward integer linear programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b FreeCellStatistics-lp.ecl -e main > out-file

:- set_stream(log_output, null).
:- set_stream(warning_output, null). 

:- lib(eplex).

model(N, Pd, Pg, D, G, Wd, Wg) :-
    integers([D, G, Wd, Wg]),
    D $:: 1..N,
    G $>= D,
    
    Wd $>=0, Wd $=< D,
    Wg $>=0, Wg $=< G,
    Wg $>= Wd,
    Wg $=< G - D + Wd,
    
    100 * Wd $= Pd * D,
    100 * Wg $= Pg * G.

find :- 
    eplex_solver_setup(min(0)), 
    eplex_solve(_).

do_case(Case_num, N, Pd, Pg) :-
    model(N, Pd, Pg, _D, _G, _Wd, _Wg),         
    printf("Case #%w: ", [Case_num]),
    ( find ->              
        write("Possible")
    ;             
        write("Broken") 
    ),
    nl, 
    eplex_cleanup.
    
main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([N, Pd, Pg]),
        do_case(Case_num, N, Pd, Pg) ).
