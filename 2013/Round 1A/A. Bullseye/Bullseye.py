# Google Code Jam
# Round 1A 2013
# A. Bullseye
# https://code.google.com/codejam/contest/2418487/dashboard#s=p0
#
# Binary search solution in Python.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

def paint(r, n):
    return 2*r*n + 2*n*n - n

def find_max(r, t):
    lo = 0
    hi = t
    while lo < hi:
        mid = 1 + (lo + hi) // 2
        if paint(r, mid) <= t:
            lo = mid
        else:
            hi = mid - 1
    return lo

def do_case(case_num, r, t):
    result = find_max(r, t)
    print "Case #%d: %d" % (case_num, result)

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        r, t = map(int, raw_input().split())
        do_case(case_num, r, t)

if __name__ == "__main__":
    main()
