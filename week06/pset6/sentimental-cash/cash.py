import sys
from cs50 import get_float
from decimal import Decimal


def main():
    while True:
        money = get_float('Money: ')
        if money == None:
            print("Sorry, couldn't read the input")
            sys.exit(1)
        elif money >= 0:
            break
    
    coins_list = [0.25, 0.10, 0.05, 0.01]
    coins = 0
    for i in range(len(coins_list)):
        max_coins, remainder = maxCoins(coins_list[i], money)
        coins += max_coins
        money = remainder

    print(coins)
    sys.exit()


def maxCoins(coin, money):
    coins = 0
    coin = Decimal(str(coin))
    money = Decimal(str(money))
    while money - coin >= 0:
        money -= coin
        coins += 1

    return coins, money


if __name__ == '__main__':
    main()
