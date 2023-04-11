def main():
    jar = Jar()

    jar.deposit(3)
    print(str(jar))
    jar.withdraw(1)
    print(str(jar))
    print(jar.capacity)
    print(jar.size)


class Jar:
    def __init__(self, capacity=12):
        if capacity < 0:
            raise ValueError('Have you ever seen a jar with a negative capacity?')
        self.max_volume = capacity
        self.cookies = 0

    def __str__(self):
        return '🍪' * self.cookies

    def deposit(self, n):
        if self.cookies + n > self.max_volume:
            raise ValueError("You'll overflow the capacity of cookies")
        else:
            self.cookies += n

    def withdraw(self, n):
        if self.cookies - n < 0:
            raise ValueError('How can you get more cookies than we have?')
        else:
            self.cookies -= n

    @property
    def capacity(self):
        return self.max_volume

    @property
    def size(self):
        return self.cookies


if __name__ == '__main__':
    main()
