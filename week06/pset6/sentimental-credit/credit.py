from cs50 import get_int
import re


def main():
    card = get_int('Number: ')
    if card == None:
        print("Cound't get credit card number")

    card_name = ''
    if cardIsValid(card):
        card_str = str(card)
        if re.match(r'^4\d{12}(?:\d{3})?$', card_str):
            card_name = 'VISA'
        if re.match(r'^33|37\d{13}$', card_str):
            card_name = 'AMEX'
        if re.match(r'^5[1-5]\d{14}$', card_str):
            card_name = 'MASTERCARD'

    if card_name == '':
        print('INVALID')
    else:
        print(card_name)


def cardIsValid(n):
    digits_second = getDigit(n, 2)
    for i in range(len(digits_second)):
        digits_second[i] = digits_second[i] * 2
        if digits_second[i] >= 10:
            split = getDigit(digits_second[i], 1)
            digits_second[i] = 0
            for digit in split:
                digits_second.append(digit)

    second_sum = sum(digits_second)
    first_sum = sum(getDigit(n, 2, 1))
    total = second_sum + first_sum
    if total % 10 == 0:
        return True
    else:
        return False


def getDigit(n, jump, start=0):
    if start == 0:
        dec = jump
    else:
        dec = start
    
    digits = []
    if dec == 1:
        digits.append(n % 10)
        dec += jump
        while (10**dec <= n * 10):
            digits.append(((n % 10**dec) - (n % 10**(dec - 1))) / 10**(dec - 1))
            dec += jump
    elif dec >= 2:
        while (10**dec <= n * 10):
            digits.append(((n % 10**dec) - (n % 10**(dec - 1))) / 10**(dec - 1))
            dec += jump

    return digits


if __name__ == '__main__':
    main()
