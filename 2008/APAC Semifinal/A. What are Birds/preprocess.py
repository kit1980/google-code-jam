def main():
    while True:
        try:
            s = raw_input().strip()
            s = s.replace("NOT BIRD", "0")
            s = s.replace("BIRD", "1")
            print s
        except EOFError:
            break

if __name__ == "__main__":
    main()
