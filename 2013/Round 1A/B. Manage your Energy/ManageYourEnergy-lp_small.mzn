% See ManageYourEnergy-mzn-lp_small.py

int: r;
int: e;
int: n;
array [1..n] of int: vs;

array [1..n] of var int: es;
array [1..n] of var int: js;
array [1..n] of var int: ss;
var int: s;

constraint es[1] = e;
constraint forall(i in 1 .. n) (es[i] >= 0 /\ es[i] <= e /\ es[i] - js[i] >= 0 /\ js[i] >= 0);
constraint forall(i in 2 .. n) (es[i] <= es[i - 1] - js[i - 1] + r);
constraint forall(i in 1 .. n) (ss[i] = vs[i] * js[i]);

constraint s = sum(ss);

solve maximize s;

output [show(s)];
