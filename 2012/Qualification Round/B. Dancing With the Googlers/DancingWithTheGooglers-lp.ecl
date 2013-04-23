% Google Code Jam
% Qualification Round 2012
% B. Dancing With the Googlers
% https://code.google.com/codejam/contest/1460488/dashboard#s=p1
%
% Integer linear programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b DancingWithTheGooglers-lp.ecl -e main > out-file

:- set_stream(log_output, null).
:- lib(eplex).

model(S, P, Points, Triplets, GtP) :-
    integers(GtP),
    length(Points, N),
    length(Triplets, N),
    ( foreach(Triplet, Triplets), foreach(Point, Points), fromto(0, SPrev, SCurr, S), fromto(0, GtPPrev, GtPCurr, GtP), param(P) do
        Triplet = [Min, Med, Max], Triplet $:: 0..10, integers(Triplet),
        Min $=< Med, Med $=< Max,
        Max + Med + Min $= Point,
        Surprise  $:: 0..1, integers(Surprise),
        Max - Min $=< 1 + Surprise,
        SCurr $= SPrev + Surprise,
        G $:: 0..1, integers(G),
        Max $>= G * P,
        GtPCurr $= GtPPrev + G ).
      
find(GtP, GtPVal) :-
    eplex_solver_setup(max(GtP)),
    eplex_solve(_),
    eplex_var_get(GtP, typed_solution, GtPVal),
    eplex_cleanup.

do_case(Case_num, S, P, Points) :-
    model(S, P, Points, _Triplets, GtP),
    find(GtP, GtPVal),
    printf("Case #%w: %w\n", [Case_num, GtPVal]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([_N, S, P | Points]),
        do_case(Case_num, S, P, Points) ).
