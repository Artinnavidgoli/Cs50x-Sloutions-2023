import csv
import requests


def main():
    # Read NYTimes Covid Database
    download = requests.get(
        "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv"
    )
    decoded_content = download.content.decode("utf-8")
    file = decoded_content.splitlines()
    reader = csv.DictReader(file)

    # Construct 14 day lists of new cases for each states
    new_cases = calculate(reader)

    # Create a list to store selected states
    states = []
    print("Choose one or more states to view average COVID cases.")
    print("Press enter when done.\n")

    while True:
        state = input("State: ")
        if state in new_cases:
            states.append(state)
        if len(state) == 0:
            break

    print(f"\nSeven-Day Averages")

    # Print out 7-day averages for this week vs last week
    comparative_averages(new_cases, states)


# TODO: Create a dictionary to store 14 most recent days of new cases by state
def calculate(reader):
    new_cases = dict()
    prev_cases = dict()
    for row in reader:
        state = row['state']
        cases = int(row['cases'])

        if state not in prev_cases:
            prev_cases[state] = cases
            new_cases[state] = []
        else:
            new_cases[state].append(cases - prev_cases[state])
            prev_cases[state] = cases

            if len(new_cases[state]) > 14:
                new_cases[state].pop(0)

    return new_cases


# TODO: Calculate and print out seven day average for given state
def comparative_averages(new_cases, states):
    for state in states:
        sum_prev = sum(new_cases[state][0:7])
        avg_prev = sum_prev / 7
        sum_curr = sum(new_cases[state][7:14])
        avg_curr = sum_curr / 7

        diff = avg_curr - avg_prev
        if diff < 0:
            diff *= -1
            status = 'a decrease'
        else:
            status = 'an increase'

        pct = diff / avg_prev * 100

        print(f'{state} had a 7-day average of {avg_curr:.0f} and {status} of {pct:.2f}%')


main()
