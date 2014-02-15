# Google Code Jam
# Round 1A 2008
# C. Numbers
# https://code.google.com/codejam/contest/32016/dashboard#s=p2
#
# Python solution using standard decimal module.
# Works fast enough for the small inputs only.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
# Python 2.7.5

from decimal import Decimal

def f(n):
    x = (3 + Decimal(5).sqrt()) ** n
    return "%03d" % int(x % 1000)

def do_case(case_num, n):
    print "Case #%d: %s" % (case_num, f(n))

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        n = int(raw_input())
        do_case(case_num, n)

if __name__ == "__main__":
    main()
