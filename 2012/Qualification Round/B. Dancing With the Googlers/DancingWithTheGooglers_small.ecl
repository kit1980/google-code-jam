% Google Code Jam
% Qualification Round 2012
% B. Dancing With the Googlers
% https://code.google.com/codejam/contest/1460488/dashboard#s=p1
%
% Constraint programming solution in ECLiPSe Prolog.
% Works for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.1 #191 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b DancingWithTheGooglers_small.ecl -e main > out-file

:- set_stream(log_output, null).
:- lib(ic).
:- lib(branch_and_bound).

model(S, P, Points, Triplets, GtP) :-
    length(Points, N),
    length(Triplets, N),
    ( foreach(Triplet, Triplets), foreach(Point, Points), fromto(0, SPrev, SCurr, S), fromto(0, GtPPrev, GtPCurr, GtP), param(P) do
        Triplet = [Min, Med, Max],
        Triplet :: 0..10,
        Min #=< Med, Med #=< Max,
        Max - Min #=< 2,
        Max + Med + Min #= Point,
        SCurr #= SPrev + (Max - Min #= 2),
        GtPCurr #= GtPPrev + (Max >= P ) ).
      
find(Triplets, GtP) :-
   flatten(Triplets, Vars),
   Cost #= -GtP,
   bb_min(labeling(Vars), Cost, bb_options{strategy: dichotomic}).

do_case(Case_num, S, P, Points) :-
    model(S, P, Points, Triplets, GtP),
    find(Triplets, GtP),
    printf("Case #%w: %w\n", [Case_num, GtP]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([_N, S, P | Points]),
        do_case(Case_num, S, P, Points) ).
