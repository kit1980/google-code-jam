% Google Code Jam
% Qualification Round 2009
% A. Alien Language
% https://code.google.com/codejam/contest/90101/dashboard#s=p0
%
% Regular expressions based solution in ECLiPSe Prolog.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.0 #199 - http://www.eclipseclp.org/
% Usage:
% eclipse -b AlienLanguage-regex.ecl -e main < in-file > out-file

:- lib(util). % for read_line/1
:- lib(regex).

replace_bracket(0'(, 0'[) :- !.
replace_bracket(0'), 0']) :- !.
replace_bracket(C, C).

do_case(Case_num, Words, InitialPattern) :-
    string_length(InitialPattern, L),
    ( for(I, 1, L), foreach(C_new, PatternList), param(InitialPattern) do
        C_old is InitialPattern[I],
        replace_bracket(C_old, C_new) ),
    string_list(PatternString, PatternList),
    compile_pattern(PatternString, [], CompiledPattern),
    ( foreach(W, Words), fromto(0, Prev, Curr, Count), param(CompiledPattern) do
        ( match(CompiledPattern, W) ->
            Curr is Prev + 1
        ;
            Curr is Prev
        )
    ),
    printf("Case #%w: %w\n", [Case_num, Count]).
        
main :-
    read_token(_L, integer),
    read_token(D, integer),
    read_token(N, integer),
    read_line(_), % eat newline
    ( for(_I, 1, D), foreach(W, Words) do
        read_line(W) ),
    ( for(Case_num, 1, N), param(Words) do
        read_line(Pattern),
        do_case(Case_num, Words, Pattern) ).
