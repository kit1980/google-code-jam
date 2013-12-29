% Google Code Jam
% Round 2 2012
% A. Swinging Wild
% https://code.google.com/codejam/contest/1842485/dashboard#s=p0
%
% Top-down dynamic programming solution in B-Prolog.
% Works fast enough for the small inputs only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% B-Prolog 8.0#1 - http://www.probp.com/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | bp -g "['SwingingWild_small.pl'],main,halt" -l | tail -n +5 > out-file

:- table path(+,+,+,max).

edge(A, B, Ha, Hb) :-
    vine(A, Da, _),
    vine(B, Db, Lb),
    B > A,
    Db - Da =< Ha,
    Hb is min(Db - Da, Lb).

path(A, B, Ha, Hb) :-
    edge(A, B, Ha, Hb).

path(A, B, Ha, Hb) :-
    edge(A, C, Ha, Hc),
    path(C, B, Hc, Hb).

do_case(Case_num, Love) :-
    vine(1, D1, _L1),
    ( path(1, Love, D1, _) ->
        format("Case #~w: YES\n", [Case_num])
    ;
        format("Case #~w: NO\n", [Case_num])
    ).

main :-
    read([T]),
    foreach(Case_num in 1..T, [N, Love, D], (
            initialize_table, abolish,
            read([N]),
            foreach(I in 1..N, [Di, Li], (
                    read([Di, Li]),
                    assert(vine(I, Di, Li))
                )),
            read([D]),
            Love is N + 1,
            assert(vine(Love, D, D)),
            do_case(Case_num, Love)
        )).
