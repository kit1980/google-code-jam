% Google Code Jam
% Round 1B 2012
% C. Equal Sums
% https://code.google.com/codejam/contest/1836486/dashboard#s=p2
%
% Straigthforward constraint programming solution in ECLiPSe Prolog.
% Works for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b EqualSums_small.ecl -e main > out-file

:- lib(ic).

model(Ss, As, Bs) :-
    length(Ss, N),
    length(As, N), As :: 0..1, sum(As) #> 0,
    length(Bs, N), Bs :: 0..1, sum(Bs) #> 0,
    As * Ss #= Bs * Ss,
    ( foreach(Ai, As), foreach(Bi, Bs), fromto(0, PrevOr, CurrOr, Or) do
        Ai + Bi #=< 1,
        CurrOr #= PrevOr or (Ai #\= Bi) ),
    Or #= 1.
    
find(As, Bs) :-
    labeling(As),
    labeling(Bs).
    
print_values(Ss, Xs) :-
    ( foreach(Xi, Xs), foreach(Si, Ss) do
        (Xi > 0 ->
            printf("%w ", [Si])
        ;
            true
        )
    ).        

do_case(Case_num, Ss) :-
    printf("Case #%w:\n", [Case_num]),
    ( model(Ss, As, Bs), find(As, Bs) ->
        print_values(Ss, As),
        nl,
        print_values(Ss, Bs)
    ;
        write("Impossible")
    ),
    nl.

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([_N | Ss]),
        do_case(Case_num, Ss) ).
