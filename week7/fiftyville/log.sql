-- Keep a log of any SQL queries you execute as you solve the mystery.

-- Who the thief is?
-- Where the thief escaped to?
-- Who the thief's accomplice was who helped them escape town?
-- 1
SELECT description FROM crime_scene_reports WHERE month = 7 AND day = 28 AND year = 2024 AND street = 'Humphrey Street';

-- 2
-- Name and transcript from interviews that mentioned the bakery that day
SELECT name, transcript FROM interviews WHERE month = 7 AND day = 28 AND year = 2024 AND transcript LIKE '%bakery%';
-- Ruth
-- Eugene
-- Raymond

-- 3
-- License plate of activity in the parking lot of bakery
SELECT activity, license_plate, hour, minute FROM bakery_security_logs
WHERE month = 7 AND day = 28 AND year = 2024 AND hour = 10 AND minute BETWEEN 15 AND 25;

-- | activity | license_plate | hour | minute |
-- +----------+---------------+------+--------+
-- | entrance | R3G7486       | 10   | 8      |
-- | entrance | 13FNH73       | 10   | 14     |
-- | exit     | 5P2BI95       | 10   | 16     |
-- | exit     | 94KL13X       | 10   | 18     |
-- | exit     | 6P58WS2       | 10   | 18     |
-- | exit     | 4328GD8       | 10   | 19     |
-- | exit     | G412CB7       | 10   | 20     |
--
SELECT name FROM people WHERE license_plate IN (
    SELECT license_plate FROM bakery_security_logs
    WHERE month = 7 AND day = 28 AND year = 2024 AND hour = 10 AND minute <= 16
);
-- Vanessa |
-- Barry   |
-- Brandon |
-- Iman    |
-- Sofia   |
-- Taylor  |
-- Luca    |
-- Diana   |
-- Kelsey  |
-- Denise  |
-- Thomas  |
-- Bruce   |
-- Sophia  |
-- Jeremy  |

-- 4
-- Persons who make a withdraw transaction that day on the Leggett Street ATM
SELECT name FROM people
JOIN bank_accounts ON people.id = bank_accounts.person_id WHERE account_number IN (
    SELECT account_number from atm_transactions WHERE atm_location = 'Leggett Street' AND transaction_type = 'withdraw' AND month = 7 AND day = 28 AND year = 2024
);
-- Bruce
-- Diana
-- Brooke-
-- Kenny-
-- Iman
-- Luca
-- Taylor
-- Benista-
--
SELECT account_number from atm_transactions WHERE atm_location = 'Leggett Street' AND transaction_type = 'withdraw' AND month = 7 AND day = 28 AND year = 2024;

-- 5
-- Caller's and receiver's phone numbers that day with a duration less than 1 minute
SELECT caller, receiver FROM phone_calls WHERE month = 7 AND day = 28 AND year = 2024 AND duration < 60;
--
-- Received a call with a duration less than 1 minute that day
SELECT name FROM people WHERE phone_number IN (
    SELECT receiver FROM phone_calls
        WHERE month = 7 AND day = 28 AND year = 2024 AND duration < 60
);
-- | James      |
-- | Larry      |
-- | Anna       |
-- | Jack       |
-- | Melissa    |
-- | Jacqueline |
-- | Philip     |
-- | Robin      |
-- | Doris      |

-- 7
-- Ariport and citys of destination the next day of the thief
SELECT id, full_name, city FROM airports WHERE airports.id IN (
    SELECT destination_airport_id FROM flights WHERE month = 7 AND day = 29 AND year = 2024 ORDER BY hour
);
-- 1  | O'Hare International Airport        | Chicago       |
-- 4  | LaGuardia Airport                   | New York City |
-- 6  | Logan International Airport         | Boston        |
-- 9  | Tokyo International Airport         | Tokyo         |
-- 11 | San Francisco International Airport | San Francisco |

-- 8
-- flights at first hour the day 29 from Fiftyville Airport ID 8
SELECT flights.* FROM flights
JOIN airports origin ON flights.origin_airport_id = origin.id
JOIN airports destination ON flights.destination_airport_id = destination.id
WHERE origin.id = 8 AND month = 7 AND day = 29 AND year = 2024
ORDER BY flights.hour, flights.minute;
-- | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
-- +----+-------------------+------------------------+------+-------+-----+------+--------+
-- | 36 | 8                 | 4                      | 2024 | 7     | 29  | 8    | 20     |
-- | 43 | 8                 | 1                      | 2024 | 7     | 29  | 9    | 30     |
-- | 23 | 8                 | 11                     | 2024 | 7     | 29  | 12   | 15     |
-- | 53 | 8                 | 9                      | 2024 | 7     | 29  | 15   | 20     |
-- | 18 | 8                 | 6                      | 2024 | 7     | 29  | 16   | 0      |

--9
SELECT passport_number FROM passengers
JOIN flights ON flights.id = passengers.flight_id
WHERE (month = 7 AND day = 28 AND year = 2024)
AND passport_number IN (
    SELECT name FROM people
);

-- 10
SELECT destination_airport_id, name, phone_number, license_plate FROM people
JOIN passengers on people.passport_number = passengers.passport_number
JOIN flights ON flights.id = passengers.flight_id
WHERE flights.id = 36
ORDER BY flights.hour ASC;
-- | 4                      | Doris  | (066) 555-9701 | M51FA04       |
-- | 4                      | Sofia  | (130) 555-0289 | G412CB7       |
-- | 4                      | Bruce  | (367) 555-5533 | 94KL13X       |
-- | 4                      | Edward | (328) 555-1152 | 130LD9Z       |
-- | 4                      | Kelsey | (499) 555-9472 | 0NTHK55       |
-- | 4                      | Taylor | (286) 555-6063 | 1106N58       |
-- | 4                      | Kenny  | (826) 555-1652 | 30G67EN       |
-- | 4                      | Luca   | (389) 555-5198 | 4328GD8       |

-- 11
SELECT people.name FROM atm_transactions
JOIN bank_accounts ON bank_accounts.account_number = atm_transactions.account_number
JOIN people ON people.id = bank_accounts.person_id
JOIN bakery_security_logs ON bakery_security_logs.license_plate = people.license_plate
WHERE atm_transactions.month = 7 AND atm_transactions.day = 28 AND atm_transactions.year = 2024
AND atm_location = 'Leggett Street'
AND bakery_security_logs.hour BETWEEN 9 AND 11
ORDER BY bakery_security_logs.minute;
-- Luca   |
-- Bruce  |
-- Brooke |
-- Luca   |
-- Iman   |
-- Diana  |
-- Taylor |

-- 12
-- Suspect of the crime
SELECT people.name FROM bakery_security_logs
JOIN people ON people.license_plate = bakery_security_logs.license_plate
JOIN bank_accounts ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
JOIN phone_calls ON phone_calls.caller = people.phone_number
WHERE bakery_security_logs.month = 7 AND bakery_security_logs.day = 28 AND bakery_security_logs.year = 2024
AND bakery_security_logs.hour = 10 AND minute BETWEEN 15 AND 25
AND atm_transactions.atm_location = 'Leggett Street' AND atm_transactions.month = 7 AND atm_transactions.day = 28 AND atm_transactions.year = 2024
AND atm_transactions.transaction_type = 'withdraw' AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.year = 2024 AND phone_calls.duration < 60;
-- | Bruce |
-- | Diana |

-- 13
-- Catch the thief
SELECT people.name FROM people
JOIN passengers ON people.passport_number = passengers.passport_number
WHERE passengers.flight_id = 36
AND people.name IN ('Bruce', 'Diana');
-- | Bruce |

-- 14
-- Call reveicer from the Bruce's phone number
SELECT receiving.name FROM phone_calls
JOIN people calling ON phone_calls.caller = calling.phone_number
JOIN people receiving ON phone_calls.receiver = receiving.phone_number
WHERE calling.name = 'Bruce' AND phone_calls.month = 7 AND phone_calls.day = 28 AND phone_calls.year = 2024 AND phone_calls.duration < 60;
