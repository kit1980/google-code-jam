# Google Code Jam
# Qualification Round Africa 2010
# A. Store Credit
# https://code.google.com/codejam/contest/351101/dashboard#s=p0
#
# Solution using Potassco: the Potsdam Answer Set Solving Collection.
# Python program used as a driver to call Potassco.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# gringo 3.0.4, clasp 2.1.1 http://potassco.sourceforge.net/
# Python 2.6.5
# Usage:
# python StoreCredit-potassco.py < in-file > out-file

import os
import re

def do_case(case_num, credit, items):
    data = ""
    data += "credit(%d).\n" % credit
    for i in range(len(items)):
        data += "item(%d, %d).\n" % (i + 1, items[i])

    tmp = open("_tmp.lp", 'w')
    tmp.write(data)
    tmp.close()

    answer_set = os.popen("gringo StoreCredit.lp _tmp.lp | clasp --verbose=0").readline().strip()
    result = " ".join(re.match("choose\((\d+),(\d+)\)", answer_set).groups())
    print "Case #%d: %s" % (case_num, result)
    
def main():
    n = int(raw_input())
    for case_num in range(1, n + 1):
        credit = int(raw_input())
        _i = int(raw_input())
        items = map(int, raw_input().split())
        do_case(case_num, credit, items)

if __name__ == "__main__":
    main()
