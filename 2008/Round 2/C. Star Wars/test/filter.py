def main():
    while True:
        try:
            a, b = raw_input().strip().split(":")
            print a + ": " + str(round(float(b), 6))
        except EOFError:
            break

if __name__ == "__main__":
    main()


