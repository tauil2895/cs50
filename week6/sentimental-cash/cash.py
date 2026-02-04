from cs50 import get_float

# propmt the change
while True:
    change_owed = 0
    coins = 0
    while change_owed <= 0:
        change_owed = get_float("Change: ")
        # convert from decimal to int
        change = round(change_owed * 100)

    # get the coins we need to change
    while change > 0:
        if change >= 25:
            change -= 25
            coins += 1
        elif change >= 10:
            change -= 10
            coins += 1
        elif change >= 5:
            change -= 5
            coins += 1
        elif change >= 1:
            change -= 1
            coins += 1
    # print coins
    print("Coins: ", coins)
    break
