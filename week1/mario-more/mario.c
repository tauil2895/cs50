#include <cs50.h>
#include <stdio.h>
void print_row(int bricks);

int main()
{
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (height < 1);

    for (int row = 0; row < height; row++)
    {
        for (int spaces = 0; spaces < height - row - 1; spaces++)
        {
            printf(" ");
        }

        print_row(row + 1);
    }
}

void print_row(int bricks)
{
    for (int col = 0; col < bricks; col++)
    {
        printf("#");
    }
    printf("  ");
    for (int col = 0; col < bricks; col++)
    {
        printf("#");
    }
    printf("\n");
}
