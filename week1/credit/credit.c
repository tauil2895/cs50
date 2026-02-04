#include <cs50.h>
#include <stdio.h>

int main()
{
    long credit;
    long credit_copy;
    int total_sum = 0, pos = 0, length = 0;
    do
    {
        credit = get_long("Credit card number: ");
        credit_copy = credit;
        while (credit != 0)
        {
            if (pos % 2 != 0) // Every other position
            {
                int temp = 2 * (credit % 10); // 2 times the modular of the credit
                if (temp > 9)                 // if is greater than 9
                {
                    total_sum += (temp / 10 + temp % 10); // 12 sum 1 + 2
                }
                else
                {
                    total_sum += temp;
                }
            }
            else
            {
                total_sum += credit % 10;
            }
            credit = credit / 10;
            pos++;
            length++;
        }
    }
    while (credit != 0);

    // AMEX start 34 and 37 with 15 digits
    // Mastercard start 51, 52, 53, 54 and 55 with 16 digits
    // VISA start 4 with 13 and 16 digits

    if (total_sum % 10 == 0)
    {
        long amex_start = credit_copy / 10000000000000;
        if ((amex_start == 34 || amex_start == 37) && (length == 15))
        {
            printf("AMEX\n");
            return 0;
        }

        long mastercard_start = credit_copy / 100000000000000;
        if ((mastercard_start >= 51 && mastercard_start <= 55) && (length == 16))
        {
            printf("MASTERCARD\n");
            return 0;
        }

        long visa_start = credit_copy / 1000000000000;
        if ((visa_start == 4 || mastercard_start / 10 == 4) && (length == 13 || length == 16))
        {
            printf("VISA\n");
            return 0;
        }
        printf("INVALID\n");
    }
    else
    {
        printf("INVALID\n");
    }
}
