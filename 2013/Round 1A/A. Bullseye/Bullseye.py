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
    min_n = 0
    max_n = t + 1
    while max_n - min_n > 1:
        med_n = (max_n - min_n) // 2 + min_n
        if paint(r, med_n) <= t:
            min_n = med_n
        else:
            max_n = med_n
    return min_n

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
