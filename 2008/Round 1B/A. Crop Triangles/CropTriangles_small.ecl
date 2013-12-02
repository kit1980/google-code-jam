% Google Code Jam 
% Round 1B 2008
% A. Crop Triangles
% https://code.google.com/codejam/contest/32017/dashboard#s=p0
%
% Straightforward constraint programming solution in ECLiPSe Prolog.
% Works fast enough for small inputs only.
%
% Author: Sergey Dymchenko <kit1980@gmail.com>
%
% ECLiPSe 6.1 #165 - http://www.eclipseclp.org/
% Usage:
% sed 's/^ */[/; s/ *$/]./; s/ \+/, /g' in-file | eclipse -b CropTriangles_small.ecl -e main > out-file

:- set_stream(log_output, stderr).

:- lib(ic). % lib(gfd) uses more time

model(Xs, Ys, I1, I2, I3) :-
    I1 #>= 1, I2 #>= 1, I3 #>= 1,
    I1 #< I2, I2 #< I3,
    element(I1, Xs, X1), element(I2, Xs, X2), element(I3, Xs, X3),
    element(I1, Ys, Y1), element(I2, Ys, Y2), element(I3, Ys, Y3),

    (X1 + X2 + X3) / 3 #= _, % integrality of (X1 + X2 + X3) / 3
    (Y1 + Y2 + Y3) / 3 #= _. % integrality of (Y1 + Y2 + Y3) / 3
    
find(I1, I2, I3) :-
    labeling([I1, I2, I3]).

generate_trees(N, A, B, C, D, X0, Y0, M, Xs, Ys) :-
    dim(Xs, [N]),
    dim(Ys, [N]),
    ( foreacharg(Xi, Xs), foreacharg(Yi, Ys), 
        fromto(X0, Xcurr, Xnext, _), fromto(Y0, Ycurr, Ynext, _),
        param(A, B, C, D, M) do
        Xi is Xcurr, 
        Yi is Ycurr,
        Xnext is (A * Xcurr + B) mod M,
        Ynext is (C * Ycurr + D) mod M ).
        
do_case(Case_num, N, A, B, C, D, X0, Y0, M) :-
    generate_trees(N, A, B, C, D, X0, Y0, M, Xs, Ys),
    model(Xs, Ys, I1, I2, I3), 
    findall(_, find(I1, I2, I3), Solutions),
    length(Solutions, K),
    printf("Case #%w: %w\n", [Case_num, K]).

main :-
    read([T]),
    ( for(Case_num, 1, T) do
        read([N, A, B, C, D, X0, Y0, M]),
        do_case(Case_num, N, A, B, C, D, X0, Y0, M) ).
