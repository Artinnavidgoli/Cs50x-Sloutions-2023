#include <cs50.h>
#include <stdio.h>
#include <string.h>

const int BITS_IN_BYTE = 8;

void print_bulb(int bit);

int main(void)
{
    string phrase = get_string("Phrase: ");
    
    int phrase_length = strlen(phrase);
    for (int i = 0; i < phrase_length; i++)
    {
        int last_bit = 128;
        int sum_of_bit = 0;
        for (int j = 0; j < BITS_IN_BYTE; j++)
        {
            if (last_bit + sum_of_bit <= phrase[i]) 
            {
                sum_of_bit += last_bit;
                print_bulb(1);
            }
            else
            {
                print_bulb(0);
            }
            last_bit = last_bit / 2;
        }
        printf("\n");
    }
}

void print_bulb(int bit)
{
    if (bit == 0)
    {
        // Dark emoji
        printf("\U000026AB");
    }
    else if (bit == 1)
    {
        // Light emoji
        printf("\U0001F7E1");
    }
}
