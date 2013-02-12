% See MountainView-mzn-lp_small.py

int: n;
array [1..n-1] of int: xs;

array [1..n] of var 0..1000000000: ys;

constraint forall(i in 1 .. n - 1, j in i + 1 .. xs[i] - 1) ((xs[i] - i) * (ys[j] - ys[i]) < (ys[xs[i]] - ys[i]) * (j - i));
constraint forall(i in 1 .. n - 1, j in xs[i] + 1 .. n) ((xs[i] - i) * (ys[j] - ys[i]) <= (ys[xs[i]] - ys[i]) * (j - i));

solve satisfy;

output [show(ys)];
