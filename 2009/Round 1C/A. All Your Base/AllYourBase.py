# Google Code Jam
# Round 1C 2009
# A. All Your Base
# https://code.google.com/codejam/contest/189252/dashboard#s=p0
#
# Solution in Python that uses int(x[, base]) function.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

def solve(s):
    order = "1023456789abcdefghijklmnopqrstuvwxyz" # NB: 1 before 0
    base = max(len(set(s)), 2)

    curr_pos = 0
    min_map = {}
    min_s = ""
    for c in s:
        if not c in min_map:
            min_map[c] = order[curr_pos]
            curr_pos += 1
        min_s += min_map[c]
    return int(min_s, base)

def do_case(case_num, s):
    print "Case #%s: %s" % (case_num, solve(s))

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        s = raw_input().strip()
        do_case(case_num, s)

if __name__ == "__main__":
    main()
