import csv
import sys


def main(argc, argv):
    dtb_path = argv[1]
    seq_path = argv[2]
    if argc != 3:
        print('Usage: python ./dna <database> <sequence>')
        sys.exit(1)
    elif dtb_path[-4:] != '.csv':
        print('The database informed is not in the databases folder')
        sys.exit(1)
    elif seq_path[-4:] != '.txt':
        print('The sequence informed is not in the sequences folder')
        sys.exit(1)

    with open(dtb_path) as dtb_file:
        dtb_dict = csv.DictReader(dtb_file)
        temp = next(dtb_dict)
        temp.pop('name')
        subseqs = temp.keys()

    match_person = 'No match'
    with open(dtb_path) as dtb_file:
        dtb_dict = csv.DictReader(dtb_file)

        with open(seq_path) as seq_file:
            seq = seq_file.read()

            suspect = {}
            for subseq in subseqs:
                longest_match = longestMatch(seq, subseq)
                suspect.update({subseq: str(longest_match)})

            subseqs_amount = len(subseqs)
            for person in dtb_dict:
                check = 0
                for subseq in subseqs:
                    if person.get(subseq) == suspect.get(subseq):
                        check += 1
                if check == subseqs_amount:
                    match_person = person.get('name')
                    break

    print(match_person)

    sys.exit(0)


def longestMatch(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1
            
            # If there is no match in the substring
            else:
                break
        
        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


if __name__ == '__main__':
    main(len(sys.argv), sys.argv)
