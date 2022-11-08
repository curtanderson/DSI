# Repository for testing git

## Description

This is a repository for testing git in the DSI Foundations of Data Science workshop. It includes my solution to the first assignment.

## Usage

My solution to the first assignment is contained in `homework.sh`. This script does three things:

- it reads a specified CSV file from the Toronto's Open Data Portal
- it prints the unique types of infractions found in the file to the standard output
- it calculates the mean, minimum, and maximum fine in that file and prints it to the standard output
- it finds all infractions of type "FAIL PARK/STP NEAR RIGHT LIMIT", extracts the infraction description, the fine amount, and the location of the fine, and stores those in infractions.csv

To invoke `homework.sh`, do the following: 

```
homework.sh parking_csv_file
```

## Contact

For help or more information, please email Curt Anderson (curt.anderson@utoronto.ca).
