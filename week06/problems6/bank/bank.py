def main():
    greeting = input('Greeting: ').strip().lower()
    hello = 'hello'
    if greeting[0] == 'h':
        for greeting_letter, hello_letter in zip(greeting[1:], hello[1:]):
            print(greeting_letter)
            if (greeting_letter != hello_letter):
                print('$20')
                return
        print('$0')
    else:
        print('$100')
        return


if __name__ == '__main__':
    main()
