#include <cs50.h>
#include <stdio.h>

//Define structure
typedef struct
{
    string name;
    int votes;
} candidate;

int main(void)
{
    const int num = get_int("Number of candidates: ");

    candidate candidates[num];

    //Populate de array
    for (int i = 0; i < num; i++)
    {
        candidates[i].name = get_string("Name: ");
        candidates[i].votes = get_int("Votes: ");
    }

    //Search the highest votes
    int highest_votes = 0;
    for (int i = 0; i < num; i++)
    {
        if (candidates[i].votes > highest_votes)
        {
            highest_votes = candidates[i].votes;
        }

    }
    for (int i = 0; i < num; i++)
    {
        if (candidates[i].votes == highest_votes)
        {
            printf("%s %i\n", candidates[i].name, candidates[i].votes);
        }
    }
}
