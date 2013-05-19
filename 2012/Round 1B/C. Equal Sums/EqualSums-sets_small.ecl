% Google Code Jam
% Round 1B 2012
% C. Equal Sums
% https://code.google.com/codejam/contest/1836486/dashboard#s=p2
%
% Integer linear programming solution in ECLiPSe Prolog using ic_sets library.
% Works for the small input only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b EqualSums-sets_small.ecl -e main > out-file

:- lib(ic).
:- lib(ic_sets).

model(Ss, As, Bs) :-
    dim(Ss, [N]),
    intset(As, 1, N), #(As, Ca), Ca #> 0, 
    intset(Bs, 1, N), #(Bs, Cb), Cb #> 0, 
    As disjoint Bs, 
    weight(As, Ss, W), weight(Bs, Ss, W).

find(As, Bs) :-
    insetdomain(As, _, _, _), 
    insetdomain(Bs, _, _, _).

print_values(Ss, Xs) :-
    ( foreach(Xi, Xs), param(Ss) do
        Si is Ss[Xi],
        printf("%w ", [Si]) ).        

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
        read([N | Slist]),
        dim(Ss, [N]),
        ( foreach(S, Slist), foreacharg(S, Ss) do
            true ),
        do_case(Case_num, Ss) ).
