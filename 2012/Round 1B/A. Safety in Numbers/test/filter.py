def main():
    while True:
        try:
            case, nums = raw_input().strip().split(":")
            nums = [str(round(float(n), 5)) for n in nums.split()]
            print case + ": " + " ".join(nums)
        except EOFError:
            break

if __name__ == "__main__":
    main()


