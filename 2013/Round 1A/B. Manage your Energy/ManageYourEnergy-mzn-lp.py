# Google Code Jam
# Round 1A 2013
# B. Manage your Energy
# https://code.google.com/codejam/contest/2418487/dashboard#s=p1
#
# Straightforward integer linear programming solution in MiniZinc.
# Python program used as a driver to call MiniZinc.
# Works for the small input only - too slow for the large one.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# MiniZinc 1.6.0 http://www.minizinc.org/
# Python 2.6.5
# Usage:
# python ManageYourEnergy-mzn-lp_small.py < in-file > out-file

import os

def do_case(case_num, e, r, vs):
    n = len(vs)

    data = ""
    data += "e = %d;\n" % e
    data += "r = %d;\n" % r
    data += "n = %d;\n" % n
    data += "vs = %s;\n" % str(vs)

    tmp = open("_tmp.dzn", 'w')
    tmp.write(data)
    tmp.close()

    result = os.popen("mzn-g12mip ManageYourEnergy-lp.mzn _tmp.dzn").readline().strip()
    result = int(result)
    print "Case #%d: %d" % (case_num, result)


def main():
    t = int(raw_input())
    for case_num in range(1, t + 1):
        e, r, n = map(int, raw_input().split())
        vs = map(int, raw_input().split())
        do_case(case_num, e, r, vs)

if __name__ == "__main__":
    main()
