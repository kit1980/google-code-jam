# Google Code Jam
# Round 2 2012
# C. Mountain View
# https://code.google.com/codejam/contest/1842485/dashboard#s=p2
#
# Straightforward integer linear programming solution in MiniZinc.
# Python program used as a driver to call MiniZinc.
# Works for the small input only.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# MiniZinc 1.6.0 http://www.g12.csse.unimelb.edu.au/minizinc/
# Python 2.6.5
# Usage:
# python MountainView-mzn-lp_small.py < in-file > out-file

import os

def do_case(case_num, xs):
    n = len(xs) + 1

    data = ""
    data += "n = %d;\n" % n
    data += "xs = %s;\n" % str(xs)

    tmp = open("_tmp.dzn", 'w')
    tmp.write(data)
    tmp.close()

    result = os.popen("mzn-g12mip MountainView-lp_small.mzn _tmp.dzn").readline().strip()
    if result == "=====UNSATISFIABLE=====":
        result = "Impossible"
    else:
        result = " ".join([str(x) for x in eval(result)])

    print "Case #%d: %s" % (case_num, result)


def main():
    t = int(raw_input())
    for case_num in range(1, t + 1):
        n = int(raw_input())
        xs = map(int, raw_input().split())
        do_case(case_num, xs)


if __name__ == "__main__":
    main()
