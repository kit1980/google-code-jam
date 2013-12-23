# Google Code Jam
# Round 1C 2011
# C. Perfect Harmony
# https://code.google.com/codejam/contest/1128486/dashboard#s=p2
#
# Brute force solution in Python.
# Works fast enough for the small inputs only.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

def best_note(L, H, notes):
    for i in xrange(L, H + 1):
        good = True
        for n in notes:
            if n > i and n % i != 0:
                good = False
                break
            if i > n and i % n != 0:
                good = False
                break
        if good:
            return i
    return "NO"

def do_case(case_num, L, H, notes):
    print "Case #%d: %s" % (case_num, best_note(L, H, notes))

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        N, L, H = map(int, raw_input().split())
        notes = map(int, raw_input().split())
        do_case(case_num, L, H, notes)

if __name__ == "__main__":
    main()
