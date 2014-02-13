% Google Code Jam
% Round 2 2009
% A. Crazy Rows
% https://code.google.com/codejam/contest/204113/dashboard#s=p0
%
% Planning-based solution in B-Prolog.
% Uses preprocessed input from preprocess-prolog.py.
% Works fast enough for the small inputs only.
%
% B-Prolog 8.0#1 - http://www.probp.com/
% Usage:
% preprocess-prolog.py < in-file | bp -g "cl('CrazyRows_small.pl'),main,halt" -l | tail -n +7 > out-file

final(S) :-
    length(S, N),
    foreach((I, E) in (1..N, S), [], E =< I).

action(S, Snext, swap, 1) :-
    append(A, [B, C | D], S),
    B > C,
    append(A, [C, B | D], Snext).

do_case(Case_num, S0) :-
    bp_best_plan_unbounded(S0, Plan),
    length(Plan, K),
    format("Case #~w: ~w\n", [Case_num, K]).
    
main :-
    read(T),
    foreach(Case_num in 1..T, [S0], (
            read(S0),
            do_case(Case_num, S0)
        )).
