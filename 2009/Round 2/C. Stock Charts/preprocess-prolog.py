# Input preprocessor for Prolog-based solutions.
#
# Output:
# number of test cases.
# Then, for each test case:
# number of stocks;
# number of pairs of conflicting stocks (that can't be on the same chart);
# pairs of conflicting stock ids (stock ids are not necessarily correspond to original inputs).

def main():
    T = int(raw_input())
    print "%d." % T
    for case_num in range(1, T + 1):
        n, k = map(int, raw_input().split())
        print "%d." % n
        charts = []
        for i in range(n):
            charts.append(map(int, raw_input().split()))
        charts.sort()
        conflicts = []
        for i in range(n):
            for j in range(i + 1, n):
                if any([charts[j][x] <= charts[i][x] for x in range(k)]):
                     conflicts.append("[%d, %d]." % (i + 1, j + 1))
        print "%d." % len(conflicts)
        for conflict in conflicts:
            print conflict

if __name__ == "__main__":
    main()
