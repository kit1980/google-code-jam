# Google Code Jam
# Qualification Round 2013
# A. Tic-Tac-Toe-Tomek
# https://code.google.com/codejam/contest/2270488/dashboard#s=p0
#
# Straightforward solution in Python.
#
# Author: Sergey Dymchenko <kit1980@gmail.com>
#
# Python 2.6.5

x4 = sorted("XXXX")
x3t = sorted("XXXT")
o4 = sorted("OOOO")
o3t = sorted("OOOT")

def check(s):
    s = sorted(s)
    if s == x4 or s == x3t:
        return 'X won'
    else:
        if s == o4 or s == o3t:
            return 'O won'
        else:
            return False

def decide(board):
    s = check(board[0][0] + board[1][1] + board[2][2] + board[3][3])
    if s:
        return s

    s = check(board[0][3] + board[1][2] + board[2][1] + board[3][0])
    if s:
        return s

    for i in range(4):
        s = check(board[i])
        if s:
            return s

    for j in range(4):
        s = check(board[0][j] + board[1][j] + board[2][j] + board[3][j])
        if s:
            return s

    if max(board[0].find('.'), board[1].find('.'), board[2].find('.'), board[3].find('.')) == -1:
        return "Draw"
    else:
        return "Game has not completed"


def do_case(case_num, board):
    result = decide(board)
    print "Case #%d: %s" % (case_num, result)

def main():
    T = int(raw_input())
    for case_num in range(1, T + 1):
        board = []
        for i in range(4):
            board.append(raw_input().strip())
        raw_input()
        do_case(case_num, board)

if __name__ == "__main__":
    main()
