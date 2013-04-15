# Google Code Jam
# Qualification Round 2009
# A. Alien Language
# https://code.google.com/codejam/contest/90101/dashboard#s=p0
#
# Regular expressions based solution in Python.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

import re

def do_case(case_num, words, pattern):
    count = 0
    pattern = pattern.replace('(', '[').replace(')', ']')
    pattern = re.compile(pattern)
    for w in words:
        if pattern.match(w):
            count += 1
    print "Case #%s: %s" % (case_num, count)

def main():
    l, d, n = map(int, raw_input().split())
    words = []    
    for i in range(d):
        words.append(raw_input().strip())
    
    for case_num in range(1, n + 1):
        pattern = raw_input().strip()
        do_case(case_num, words, pattern)

if __name__ == "__main__":
    main()
