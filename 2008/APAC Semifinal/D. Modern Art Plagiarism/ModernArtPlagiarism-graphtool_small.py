# Google Code Jam
# APAC Semifinal 2008
# D. Modern Art Plagiarism
# https://code.google.com/codejam/contest/32005/dashboard#s=p3
#
# Solution in Python using graph-tool library.
# Works fast enough for the small inputs only.
#
# graph-tool 2.29.1.1 - http://graph-tool.skewed.de/
# Python 2.7.5

from graph_tool.all import *

def do_case(case_num, large, small):
    if small.num_edges() == 0 or subgraph_isomorphism(small, large, max_n=1, random=True)[0]:
        result = "YES"
    else:
        result = "NO"
    print "Case #%s: %s" % (case_num, result)

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        large = Graph(directed=False)
        n = int(raw_input())
        for i in range(n):
            large.add_vertex()
        for i in range(n - 1):
            a, b = map(int, raw_input().split())
            large.add_edge(a - 1, b - 1)

        small = Graph(directed=False)
        m = int(raw_input())
        for i in range(m):
            small.add_vertex()
        for i in range(m - 1):
            a, b = map(int, raw_input().split())
            small.add_edge(a - 1, b - 1)

        do_case(case_num, large, small)

if __name__ == "__main__":
    main()
