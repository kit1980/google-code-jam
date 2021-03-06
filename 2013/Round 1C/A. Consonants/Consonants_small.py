# Google Code Jam
# Round 1C 2013
# A. Consonants
# https://code.google.com/codejam/contest/2437488/dashboard#s=p0
#
# Brute force solution in Python.
# Works fast enough for the small inputs only.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

def nvalue(s, n):
    vovels = set("aeiou")
    k = len(s)
    result = 0
    for i in range(k):
        for j in range(i + 1, k + 1):
            best = 0
            curr = 0
            for c in s[i:j]:
                if c in vovels:
                    best = max(best, curr)
                    curr = 0
                else:
                    curr += 1
            best = max(best, curr)
            if best >= n:
                result += 1
    return result

def do_case(case_num, s, n):
    print "Case #%d: %d" % (case_num, nvalue(s, n))

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        s, n = raw_input().split()
        n = int(n)
        do_case(case_num, s, n)

if __name__ == "__main__":
    main()
