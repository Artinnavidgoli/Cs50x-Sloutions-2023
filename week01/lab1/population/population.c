#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int start;
    do
    {
        start = get_int("Start size: ");
    }
    while (start < 9);

    int end;
    do
    {
        end = get_int("End size: ");
    }
    while (end < start);

    int llamas = start;
    int years = 0;
    while (end > llamas)
    {
        int births = llamas / 3;
        int deaths = llamas / 4;
        llamas += births - deaths;
        years++;
    }

    printf("Years: %i\n", years);
}
