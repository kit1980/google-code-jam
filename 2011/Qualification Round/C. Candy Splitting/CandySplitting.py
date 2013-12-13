# Google Code Jam
# Qualification Round 2011
# C. Candy Splitting
# https://code.google.com/codejam/contest/975485/dashboard#s=p2
#
# Algorithmic solution in Python.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

import operator

def xor(vals):
    return reduce(operator.xor, vals)

def find_split(candies):
    if xor(candies) != 0:
        return "NO"
    else:
        return sum(candies) - min(candies)

def do_case(case_num, candies):
    print "Case #%d: %s" % (case_num, find_split(candies))

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        raw_input() # N is not used
        candies = map(int, raw_input().split())
        do_case(case_num, candies)

if __name__ == "__main__":
    main()
