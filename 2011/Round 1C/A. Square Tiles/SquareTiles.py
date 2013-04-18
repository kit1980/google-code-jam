# Google Code Jam
# Round 1C 2011
# A. Square Tiles
# https://code.google.com/codejam/contest/1128486/dashboard#s=p0
#
# Straightforward greedy solution in Python.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

def is_impossible(tiles):
    R = len(tiles)
    C = len(tiles[0])
    impossible = False
    for r in range(R):
        for c in range(C):
            if tiles[r][c] == "#":
                try:
                    if tiles[r][c + 1] == "." or tiles[r + 1][c] == "." or tiles[r + 1][c + 1] == ".":
                        impossible = True 
                        break   
                    tiles[r][c] = "/"
                    tiles[r][c + 1] = "\\"
                    tiles[r + 1][c] = "\\"
                    tiles[r + 1][c + 1] = "/"
                except IndexError:
                   impossible = True 
                   break
    return impossible

def do_case(case_num, tiles):
    print "Case #%d:" % case_num
    if is_impossible(tiles):
        print "Impossible"
    else:
        for row in tiles:
            print "".join(row)

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        R, C = map(int, raw_input().split())
        tiles = []
        for i in range(R):
            tiles.append(list(raw_input().strip()))
        do_case(case_num, tiles)

if __name__ == "__main__":
    main()
