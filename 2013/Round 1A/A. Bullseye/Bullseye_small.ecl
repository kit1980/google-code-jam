% Google Code Jam
% Round 1A 2013
% A. Bullseye
% https://code.google.com/codejam/contest/2418487/dashboard#s=p0
%
% Binary search solution implemented using ECLiPSe 'branch_and_bound' library.
% Works for the small input only because of imprecise presentation of large integers by floating-point numbers.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #201 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b Bullseye_small.ecl -e main > out-file

:- set_stream(log_output, null).
:- lib(ic).
:- lib(branch_and_bound).

model(R, T, N) :-
    N :: 0..T,
    2*R*N + 2*N*N - N $=< T.

find(N) :-
    Cost #= -N,
    bb_min(indomain(N), Cost, bb_options{strategy: dichotomic}).

do_case(Case_num, R, T) :-
    model(R, T, N),
    find(N),                           
    printf("Case #%w: %w\n", [Case_num, N]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([R, T]),
        do_case(Case_num, R, T) ).
