% Google Code Jam
% Round Round 1A 2008
% B. Milkshakes
% https://code.google.com/codejam/contest/32016/dashboard#s=p1
%
% Straightforward constraint programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.1 #191 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b Milkshakes.ecl -e main > out-file

:- lib(ic).

model(N, Customers, Flavors, NMalted) :-
    dim(Flavors, [N]),
    Flavors :: 0..1, % 1 - malted
    flatten_array(Flavors, FlavorsList),
    sum(FlavorsList) #= NMalted,
    NMalted #>= 0,

    ( foreacharg(Customer, Customers), param(Flavors) do
        ( foreach((Flavor, Malted), Customer), 
            fromto(0, Previous, Current, Sum), param(Flavors) do
            (Current = Previous + (Flavors[Flavor] =:= Malted)) ),
        eval(Sum) #>= 1 ).

find(Flavors, NMalted) :-
    indomain(NMalted),
    labeling(Flavors).

do_case(Case_num, N, Customers) :-
    printf("Case #%w: ", [Case_num]),
    ( model(N, Customers, Flavors, NMalted), find(Flavors, NMalted) ->
        flatten_array(Flavors, FlavorsList),
        join_string(FlavorsList, " ", Str),
        write(Str)
    ;
        write("IMPOSSIBLE")
    ),
    nl.

group([], []).
group([X, Y | T], [(X, Y) | GT]) :-
    group(T, GT).

main :-
    read([C]),
    ( for(Case_num, 1, C) do
        read([N]),
        read([M]),
        dim(Customers, [M]),
        ( foreacharg(Customer, Customers) do
            read([_T | XYs]),
            group(XYs, Customer) ),
        do_case(Case_num, N, Customers) ).
