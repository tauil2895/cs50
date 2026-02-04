#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, string argv[])
{
    // Make sure program was run with just one command-line argument
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    // Make sure every character in argv[1] is a digit
    for (int i = 0, len = strlen(argv[1]); i < len; i++)
    {
        if (!isdigit(argv[1][i]))
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }
    }

    // Convert argv[1] from a `string` to an `int`
    int key = atoi(argv[1]);

    // Take input user for plaintext
    string plaintext = get_string("plaintext: ");

    // Print the encrypt for ciphertext
    printf("ciphertext: ");

    // check if the text is alphabetic, upper, lower and change the text for the key
    for (int i = 0, len = strlen(plaintext); i < len; i++)
    {
        if (isalpha(plaintext[i]))
        {
            if (isupper(plaintext[i]))
            {
                printf("%c", (plaintext[i] - 65 + key) % 26 + 65);
            }
            else if (islower(plaintext[i]))
            {
                printf("%c", (plaintext[i] - 97 + key) % 26 + 97);
            }
        }
        else
        {
            printf("%c", plaintext[i]);
        }
    }
    printf("\n");
}
