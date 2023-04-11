-- Theft happend in a backery at 10:15am
SELECT
  *
FROM
  crime_scene_reports
WHERE
  day = 28
  AND month = 7
  AND year = 2021
  AND street = 'Humphrey Street'
  AND description LIKE '%duck%';

-- Witness transcriptions
SELECT
  *
FROM
  interviews
WHERE
  day = 28
  AND month = 7
  AND year = 2021
  AND transcript LIKE '%bakery%';
-- Eugene: thief withdraw money from a ATM located at Leggett Street
-- Ruth: within 10 minutes the thief get a car and goes away.
-- Raymond: thief makes a call less than 1m to accomplice to buy the tomorrow's earliest fly going out of Fiftyville

-- All withdraws from the ATM located at Leggett Street
SELECT
  *
FROM
  atm_transactions
WHERE
  day = 28
  AND month = 7
  AND year = 2021
  AND atm_location = 'Leggett Street'
  AND transaction_type = 'withdraw';

-- Name, phone number, passaport number, and license plate from people that was in the last query.
SELECT
  *
FROM
  people
WHERE
  id IN (
    SELECT
      person_id
    FROM
      bank_accounts
    WHERE
      account_number IN (
        SELECT
            account_number
        FROM
            atm_transactions
        WHERE
          day = 28
          AND month = 7
          AND year = 2021
          AND atm_location = 'Leggett Street'
          AND transaction_type = 'withdraw'
      )
  );

-- People from the last query that went to the bakery in a car and exited withing 10 minutes after the crime.
SELECT
  *
FROM
  people
WHERE
  license_plate IN (
    SELECT
      license_plate
    FROM
      bakery_security_logs
    WHERE
      activity = 'exit'
      AND hour = 10
      AND minute BETWEEN 15
      AND 25
      AND license_plate IN (
        SELECT
          license_plate
        FROM
          people
        WHERE
          id IN (
            SELECT
              person_id
            FROM
              bank_accounts
            WHERE
              account_number IN (
                SELECT
                  account_number
                FROM
                  atm_transactions
                WHERE
                  day = 28
                  AND month = 7
                  AND year = 2021
                  AND atm_location = 'Leggett Street'
                  AND transaction_type = 'withdraw'
              )
          )
      )
  );


-- People from the last query that made a call with a duration of less than 60 seconds
SELECT
  *
FROM
  people
WHERE
  phone_number IN (
    SELECT
      caller
    FROM
      phone_calls
    WHERE
      day = 28
      AND month = 7
      AND year = 2021
      AND duration < 60
      AND caller IN (
        SELECT
          phone_number
        FROM
          people
        WHERE
          license_plate IN (
            SELECT
              license_plate
            FROM
              bakery_security_logs
            WHERE
              activity = 'exit'
              AND hour = 10
              AND minute BETWEEN 15
              AND 25
              AND license_plate IN (
                SELECT
                  license_plate
                FROM
                  people
                WHERE
                  id IN (
                    SELECT
                      person_id
                    FROM
                      bank_accounts
                    WHERE
                      account_number IN (
                        SELECT
                          account_number
                        FROM
                          atm_transactions
                        WHERE
                          day = 28
                          AND month = 7
                          AND year = 2021
                          AND atm_location = 'Leggett Street'
                          AND transaction_type = 'withdraw'
                      )
                  )
              )
          )
      )
  );

-- Passengers details from the people on the last query
SELECT
  *
FROM
  passengers
WHERE
  passport_number IN (
    SELECT
      passport_number
    FROM
      people
    WHERE
      phone_number IN (
        SELECT
          caller
        FROM
          phone_calls
        WHERE
          day = 28
          AND month = 7
          AND year = 2021
          AND duration < 60
          AND caller IN (
            SELECT
              phone_number
            FROM
              people
            WHERE
              license_plate IN (
                SELECT
                  license_plate
                FROM
                  bakery_security_logs
                WHERE
                  activity = 'exit'
                  AND hour = 10
                  AND minute BETWEEN 15
                  AND 25
                  AND license_plate IN (
                    SELECT
                      license_plate
                    FROM
                      people
                    WHERE
                      id IN (
                        SELECT
                          person_id
                        FROM
                          bank_accounts
                        WHERE
                          account_number IN (
                            SELECT
                              account_number
                            FROM
                              atm_transactions
                            WHERE
                              day = 28
                              AND month = 7
                              AND year = 2021
                              AND atm_location = 'Leggett Street'
                              AND transaction_type = 'withdraw'
                          )
                      )
                  )
              )
          )
      )
  );

-- Flight of the last query that is the first fly on day 29 of the month 07
SELECT
  *
FROM
  flights
WHERE
  day = 29
  AND month = 7
  AND year = 2021
  AND id IN (
    SELECT
      flight_id
    FROM
      passengers
    WHERE
      passport_number IN (
        SELECT
          passport_number
        FROM
          people
        WHERE
          phone_number IN (
            SELECT
              caller
            FROM
              phone_calls
            WHERE
              day = 28
              AND month = 7
              AND year = 2021
              AND duration < 60
              AND caller IN (
                SELECT
                  phone_number
                FROM
                  people
                WHERE
                  license_plate IN (
                    SELECT
                      license_plate
                    FROM
                      bakery_security_logs
                    WHERE
                      activity = 'exit'
                      AND hour = 10
                      AND minute BETWEEN 15
                      AND 25
                      AND license_plate IN (
                        SELECT
                          license_plate
                        FROM
                          people
                        WHERE
                          id IN (
                            SELECT
                              person_id
                            FROM
                              bank_accounts
                            WHERE
                              account_number IN (
                                SELECT
                                  account_number
                                FROM
                                  atm_transactions
                                WHERE
                                  day = 28
                                  AND month = 7
                                  AND year = 2021
                                  AND atm_location = 'Leggett Street'
                                  AND transaction_type = 'withdraw'
                              )
                          )
                      )
                  )
              )
          )
      )
  )
ORDER BY
  hour ASC
LIMIT
  1;
-- Thief on the flight of id 36

-- Verifying if the fly origins in Fiftyville
SELECT
  *
FROM
  airports
WHERE
  id = (
    SELECT
      origin_airport_id
    FROM
      flights
    WHERE
      day = 29
      AND month = 7
      AND year = 2021
      AND id IN (
        SELECT
          flight_id
        FROM
          passengers
        WHERE
          passport_number IN (
            SELECT
              passport_number
            FROM
              people
            WHERE
              phone_number IN (
                SELECT
                  caller
                FROM
                  phone_calls
                WHERE
                  day = 28
                  AND month = 7
                  AND year = 2021
                  AND duration < 60
                  AND caller IN (
                    SELECT
                      phone_number
                    FROM
                      people
                    WHERE
                      license_plate IN (
                        SELECT
                          license_plate
                        FROM
                          bakery_security_logs
                        WHERE
                          activity = 'exit'
                          AND hour = 10
                          AND minute BETWEEN 15
                          AND 25
                          AND license_plate IN (
                            SELECT
                              license_plate
                            FROM
                              people
                            WHERE
                              id IN (
                                SELECT
                                  person_id
                                FROM
                                  bank_accounts
                                WHERE
                                  account_number IN (
                                    SELECT
                                      account_number
                                    FROM
                                      atm_transactions
                                    WHERE
                                      day = 28
                                      AND month = 7
                                      AND year = 2021
                                      AND atm_location = 'Leggett Street'
                                      AND transaction_type = 'withdraw'
                                  )
                              )
                          )
                      )
                  )
              )
          )
      )
    ORDER BY
      hour ASC
    LIMIT
      1
  );

-- The City that the thief is scaping to
SELECT
  city
FROM
  airports
WHERE
  id = (
    SELECT
      destination_airport_id
    FROM
      flights
    WHERE
      day = 29
      AND month = 7
      AND year = 2021
      AND id IN (
        SELECT
          flight_id
        FROM
          passengers
        WHERE
          passport_number IN (
            SELECT
              passport_number
            FROM
              people
            WHERE
              phone_number IN (
                SELECT
                  caller
                FROM
                  phone_calls
                WHERE
                  day = 28
                  AND month = 7
                  AND year = 2021
                  AND duration < 60
                  AND caller IN (
                    SELECT
                      phone_number
                    FROM
                      people
                    WHERE
                      license_plate IN (
                        SELECT
                          license_plate
                        FROM
                          bakery_security_logs
                        WHERE
                          activity = 'exit'
                          AND hour = 10
                          AND minute BETWEEN 15
                          AND 25
                          AND license_plate IN (
                            SELECT
                              license_plate
                            FROM
                              people
                            WHERE
                              id IN (
                                SELECT
                                  person_id
                                FROM
                                  bank_accounts
                                WHERE
                                  account_number IN (
                                    SELECT
                                      account_number
                                    FROM
                                      atm_transactions
                                    WHERE
                                      day = 28
                                      AND month = 7
                                      AND year = 2021
                                      AND atm_location = 'Leggett Street'
                                      AND transaction_type = 'withdraw'
                                  )
                              )
                          )
                      )
                  )
              )
          )
      )
    ORDER BY
      hour ASC
    LIMIT
      1
  );
-- It's New York City

-- Passport number of the thief on flight 36
SELECT
  passport_number
FROM
  passengers
WHERE
  flight_id = '36'
  AND passport_number IN (
    SELECT
      passport_number
    FROM
      passengers
    WHERE
      passport_number IN (
        SELECT
          passport_number
        FROM
          people
        WHERE
          phone_number IN (
            SELECT
              caller
            FROM
              phone_calls
            WHERE
              day = 28
              AND month = 7
              AND year = 2021
              AND duration < 60
              AND caller IN (
                SELECT
                  phone_number
                FROM
                  people
                WHERE
                  license_plate IN (
                    SELECT
                      license_plate
                    FROM
                      bakery_security_logs
                    WHERE
                      activity = 'exit'
                      AND hour = 10
                      AND minute BETWEEN 15
                      AND 25
                      AND license_plate IN (
                        SELECT
                          license_plate
                        FROM
                          people
                        WHERE
                          id IN (
                            SELECT
                              person_id
                            FROM
                              bank_accounts
                            WHERE
                              account_number IN (
                                SELECT
                                  account_number
                                FROM
                                  atm_transactions
                                WHERE
                                  day = 28
                                  AND month = 7
                                  AND year = 2021
                                  AND atm_location = 'Leggett Street'
                                  AND transaction_type = 'withdraw'
                              )
                          )
                      )
                  )
              )
          )
      )
  );

-- Thief data
SELECT
  *
FROM
  people
WHERE
  passport_number = (
    SELECT
      passport_number
    FROM
      passengers
    WHERE
      flight_id = '36'
      AND passport_number IN (
        SELECT
          passport_number
        FROM
          passengers
        WHERE
          passport_number IN (
            SELECT
              passport_number
            FROM
              people
            WHERE
              phone_number IN (
                SELECT
                  caller
                FROM
                  phone_calls
                WHERE
                  day = 28
                  AND month = 7
                  AND year = 2021
                  AND duration < 60
                  AND caller IN (
                    SELECT
                      phone_number
                    FROM
                      people
                    WHERE
                      license_plate IN (
                        SELECT
                          license_plate
                        FROM
                          bakery_security_logs
                        WHERE
                          activity = 'exit'
                          AND hour = 10
                          AND minute BETWEEN 15
                          AND 25
                          AND license_plate IN (
                            SELECT
                              license_plate
                            FROM
                              people
                            WHERE
                              id IN (
                                SELECT
                                  person_id
                                FROM
                                  bank_accounts
                                WHERE
                                  account_number IN (
                                    SELECT
                                      account_number
                                    FROM
                                      atm_transactions
                                    WHERE
                                      day = 28
                                      AND month = 7
                                      AND year = 2021
                                      AND atm_location = 'Leggett Street'
                                      AND transaction_type = 'withdraw'
                                  )
                              )
                          )
                      )
                  )
              )
          )
      )
  );
-- Bruce is the thief

-- Accomplice number
SELECT
  receiver
FROM
  phone_calls
WHERE
  day = 28
  AND month = 7
  AND year = 2021
  AND duration < 60
  AND caller = (
    SELECT
      phone_number
    FROM
      people
    WHERE
      name = 'Bruce'
      AND license_plate IN (
        SELECT
          license_plate
        FROM
          bakery_security_logs
        WHERE
          activity = 'exit'
          AND hour = 10
          AND minute BETWEEN 15
          AND 25
          AND license_plate IN (
            SELECT
              license_plate
            FROM
              people
            WHERE
              id IN (
                SELECT
                  person_id
                FROM
                  bank_accounts
                WHERE
                  account_number IN (
                    SELECT
                      account_number
                    FROM
                      atm_transactions
                    WHERE
                      day = 28
                      AND month = 7
                      AND year = 2021
                      AND atm_location = 'Leggett Street'
                      AND transaction_type = 'withdraw'
                  )
              )
          )
      )
  );

-- Accomplice data
SELECT
  *
FROM
  people
WHERE
  phone_number = (
    SELECT
      receiver
    FROM
      phone_calls
    WHERE
      day = 28
      AND month = 7
      AND year = 2021
      AND duration < 60
      AND caller = (
        SELECT
          phone_number
        FROM
          people
        WHERE
          name = 'Bruce'
          AND license_plate IN (
            SELECT
              license_plate
            FROM
              bakery_security_logs
            WHERE
              activity = 'exit'
              AND hour = 10
              AND minute BETWEEN 15
              AND 25
              AND license_plate IN (
                SELECT
                  license_plate
                FROM
                  people
                WHERE
                  id IN (
                    SELECT
                      person_id
                    FROM
                      bank_accounts
                    WHERE
                      account_number IN (
                        SELECT
                          account_number
                        FROM
                          atm_transactions
                        WHERE
                          day = 28
                          AND month = 7
                          AND year = 2021
                          AND atm_location = 'Leggett Street'
                          AND transaction_type = 'withdraw'
                      )
                  )
              )
          )
      )
  );
-- The accomplice name is Robin
