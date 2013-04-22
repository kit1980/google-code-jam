def main():
    while(True):
        try:
            print(raw_input())
            s1 = raw_input().strip()
            if s1 == "Impossible":
                print s1
            else:
                sum1 = sum(map(int, s1.split()))
                s2 = raw_input().strip()
                sum2 = sum(map(int, s2.split()))
                print sum1 == sum2
        except EOFError:
            break

if __name__ == "__main__":
    main()
