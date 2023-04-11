#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int convert(string input);

int main(void)
{
    string input = get_string("Enter a positive integer: ");

    for (int i = 0, n = strlen(input); i < n; i++)
    {
        if (!isdigit(input[i]))
        {
            printf("Invalid Input!\n");
            return 1;
        }
    }

    // Convert string to int
    printf("%i\n", convert(input));
}

int convert(string input)
{
    char first_char = input[0];
    if (first_char == '\0')
    {
        return 0;
    }

    int number = first_char - '0';

    int input_length = strlen(input);
    for (int i = 0; i < input_length; i++)
    {
        input[i] = input[i + 1];
    }

    int decimal_location = pow(10, input_length - 1);
    return number * decimal_location + convert(input); 
}
