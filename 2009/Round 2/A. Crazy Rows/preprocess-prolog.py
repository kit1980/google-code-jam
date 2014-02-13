# Input preprocessor for Prolog-based solutions.

def main():
    T = int(raw_input())
    print "%d." % T
    for case_num in range(1, T + 1):
        N = int(raw_input())
        s0 = []
        for i in range(N):
            s = raw_input().strip()
            val = s.rfind('1') + 1
            s0.append(val)
        print "[" + ",".join([str(val) for val in s0])  + "]."

if __name__ == "__main__":
    main()
