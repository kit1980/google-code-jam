% Google Code Jam
% Round Round 1A 2008
% B. Milkshakes
% https://code.google.com/codejam/contest/32016/dashboard#s=p1
%
% Straightforward constraint programming solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b Milkshakes.ecl -e main > out-file

:- lib(ic).

model(N, Customers, Flavours, N_malted) :-
    dim(Flavours, [N]),
    Flavours :: 0..1, % 1 - malted
    flatten_array(Flavours, Flavours_list),
    sum(Flavours_list) #= N_malted,
    N_malted #>= 0,

    ( foreacharg(Customer, Customers), param(Flavours) do
        ( foreach((Flavor, Malted), Customer), 
            fromto(0, Previous, Current, Sum), param(Flavours) do
            (Current = Previous + (Flavours[Flavor] =:= Malted)) ),
        eval(Sum) #>= 1 ).

find(Flavours, N_malted) :-
    indomain(N_malted),
    labeling(Flavours).

do_case(Case_num, N, Customers) :-
    printf("Case #%w: ", [Case_num]),
    ( model(N, Customers, Flavours, N_malted), find(Flavours, N_malted) ->
        flatten_array(Flavours, Flavours_list),
        join_string(Flavours_list, " ", Str),
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
