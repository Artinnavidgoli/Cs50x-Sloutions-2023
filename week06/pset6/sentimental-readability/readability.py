import sys
from cs50 import get_string
from decimal import Decimal as d


def main():
    msg = get_string('Text: ')
    if msg == None:
        print('Impossible to get string')
        sys.exit(1)

    msg = msg.strip()

    w = 1
    l = 0
    s = 0
    for char in msg:
        if char.isalpha():
            l += 1
        elif char == ' ':
            w += 1
        elif char in ['.', '!', '?']:
            s += 1

    l = d(str(l)) * d('100') / d(str(w))
    s = d(str(s)) * d('100') / d(str(w))

    coleman = d('0.0588') * d(str(l)) - d('0.296') * d(str(s)) - d('15.8')
    grade = round(coleman)

    if grade > 16:
        print('Grade 16+')
    elif grade < 1:
        print('Before Grade 1')
    else:
        print(f'Grade {grade}')
    

if __name__ == '__main__':
    main()
