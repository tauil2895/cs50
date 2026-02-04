#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int main(int argc, string argv[])
{
    // validate for 2 command-line argument
    if (argc != 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }

    if (strlen(argv[1]) != 26)
    {
        printf("Key must contain 26 characters\n");
        return 1;
    }

    // key only of unique alphabets
    for (int i = 0, len = strlen(argv[1]); i < len; i++)
    {

        for (int j = i + 1; j < len; j++)
        {
            if (!isalpha(argv[1][i]))
            {
                printf("Key should be only alphabeth\n");
                return 1;
            }
            if (argv[1][i] == argv[1][j])
            {
                printf("No duplicates values allowed\n");
                return 1;
            }
        }
    }

    string key = argv[1];

    // Take input user for plaintext
    string plaintext = get_string("plaintext: ");

    // Print the encrypt for ciphertext
    printf("ciphertext: ");

    // check upper, lower and change the text for the key
    for (int i = 0, len = strlen(plaintext); i < len; i++)
    {
        if (isalpha(plaintext[i]))
        {
            if (isupper(plaintext[i]))
            {
                printf("%c", toupper(key[plaintext[i] - 65]));
            }
            else
            {
                printf("%c", tolower(key[plaintext[i] - 97]));
            }
        }
        else
        {
            printf("%c", plaintext[i]);
        }
    }
    printf("\n");
}
