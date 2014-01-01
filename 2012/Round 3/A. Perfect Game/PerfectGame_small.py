# Google Code Jam
# Round 3 2012
# A. Perfect Game
# https://code.google.com/codejam/contest/1835486/dashboard#s=p0
#
# Obvious algorithmic solution in Python.
# Works for the small inputs only.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

def best_order(Ls, Ps):
    # ignore Ls for the small inputs
    return [x[0] for x in sorted(enumerate(Ps), key=lambda x: x[1], reverse=True)]

def do_case(case_num, Ls, Ps):
    order = best_order(Ls, Ps)
    order_str = " ".join(map(str, order))
    print("Case #%s: %s" % (case_num, order_str))

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        N = int(raw_input())        
        Ls = map(int, raw_input().split())
        Ps = map(int, raw_input().split())
        do_case(case_num, Ls, Ps)

if __name__ == "__main__":
    main()
