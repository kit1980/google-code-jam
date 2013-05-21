% Google Code Jam
% Round 1B 2012
% A. Safety in Numbers
% https://code.google.com/codejam/contest/1836486/dashboard#s=p0
%
% Constraint programming solution in ECLiPSe Prolog.
% Works fast enough for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b SafetyInNumbers_small.ecl -e main > out-file

:- set_stream(warning_output, stderr).

:- lib(ic).

model(Js, Ms) :-
    sum(Js, X),
    length(Js, N),
    length(Ys, N), Ys :: 0.0..1.0, sum(Ys) $= 1.0,
    length(Ms, N),
    length(Scores, N),
    ( foreach(Ji, Js), foreach(Yi, Ys), foreach(Score, Scores), param(X) do
        Score $= Ji + X * Yi ),
    ( foreach(Score, Scores), foreach(Mi, Ms), foreach(Yi, Ys), param(X, Js, Ys) do
        ( ( foreach(Ji, Js), foreach(Yi, Ys), param(X, Score) do Score $=< Ji + X * Yi ) ->
            squash([Yi], 1e-9, log),
            get_max(Yi, Mi)
        ;
            Mi is 0.0
        )
    ).
    
do_case(Case_num, Js) :-
    ( model(Js, Ms) ->
        print_case(Case_num, Ms)
    ;
        printf("Case #%w: 0\n", [Case_num])
    ).  
   
print_case(Case_num, Ms) :-
    printf("Case #%w: ", [Case_num]),
    ( foreach(Mi, Ms) do
        Mmi is 100 * Mi,
        printf("%f ", [Mmi])),
    nl.

main :-
    read([T]),
    ( for(Case_num, 1, T) do 
        read([_N | Js]),
        do_case(Case_num, Js) ).
