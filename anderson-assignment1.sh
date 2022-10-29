#!/bin/bash

###################################################
# DSI Unix Shell, Git, and Github workshop
# Assignment 1: Unix and Data
#
# Author: Curt Anderson
# Date: 2022/10/29
# Email: curt.anderson@utoronto.ca
# Invocation: anderson-assignment1.sh parking_file
###################################################

CSV_FILE=$1  # Store the first argument in a more informative variable

###################################################
# Functions
###################################################

# gets all unique infraction types from a Toronto parking ticket CSV file
function get_infraction_types {
	cut -d, -f4 $1 | sort | uniq | grep -v "infraction_description"
}

# Finds the max fine from a Toronto parking ticket CSV file.
function max_fine { 
	echo $(cut -d, -f5 $1 | sort -n | grep -v "set_fine_amount" | tail -n 1) 
}

# Finds the min fine from a Toronto parking ticket CSV file.
function min_fine { 
	echo $(cut -d, -f5 $1 | sort -n | grep -v "set_fine_amount" | head -n 1) 
}

# Finds the mean fine from a Toronto parking ticket CSV file.
function mean_fine {
	# Create an array from the fines.
	FINES=($(cut -d, -f5 $CSV_FILE | sort -n | grep -v "set_fine_amount"))

	# Initialize storage variables, loop through FINES,
	# sum up the fines, and count the total number.
	# https://www.cyberciti.biz/faq/unix-linux-iterate-over-a-variable-range-of-numbers-in-bash/
	sum=0; count=0
	for i in "${FINES[@]}"
	do
		sum=$((sum+i))
		((count+=1))
	done

	# Uses bc for the calculation since apparently bash doesn't do decimals.
	# https://unix.stackexchange.com/questions/264280/is-it-possible-to-get-a-decimal-output-from-doing-division-in-bash
	echo "$sum/$count" | bc -l
}

# get_infractions gets all infractions of a particular type from 
# a Toronto parking tickets CSV file.
# Extracts infraction_description, set_fine_amount, and location2
# Usage: get_infractions CSV_FILE INFRACTION_NAME
function get_infractions {
	echo "infraction_description,set_fine_amount,location2"
	cut -d, -f4,5,8 $1 | grep -e "$2"
}

###################################################
# Body
###################################################

# Output infraction types
get_infraction_types $CSV_FILE

# Output max fine, min fine, and mean fine
# Restricted to two decimal places since we're printing dollar amounts
printf "Maximum Fine: %.2f\nMinimum Fine: %.2f\nMean Fine: %.2f\n" \
	$(max_fine $CSV_FILE) \
	$(min_fine $CSV_FILE) \
	$(mean_fine $CSV_FILE)

# Save one type of infraction in a new CSV file
get_infractions $CSV_FILE "FAIL PARK/STP NEAR RIGHT LIMIT" > infractions.csv
