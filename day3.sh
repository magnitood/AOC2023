#!/bin/env bash

parts_sum=0
input_file=in3.txt
lines=$(\cat "$input_file")

# move each line into an array so we can index them
let counter=0
for line in $lines;
do
	line_array[counter]=$line
	let counter+=1
done

let line_length=${#line_array} # assuming every line is the same length, store the number of characters in each line
let array_length=${#line_array[@]} # store the number of lines

let counter=0
while [[ $counter -lt $array_length ]] # loop over every line with index
do
	current_line=${line_array[counter]}
	[[ "$counter" -ne 0 ]] && previous_line=${line_array[counter-1]}; # assign previous_line if it is not first line
	next_line=${line_array[counter+1]}

	let char_counter=$line_length
	let temp_sum=0;
	let temp_multiplier=1;
	will_add=false
	while [[ $char_counter -gt 0 ]] # loop over every character from right to left (like reading urdu)
	do
		let char_counter-=1

		center=${current_line: $char_counter:1}
		re='[0-9]'
		[[ ! "$center" =~ $re ]] && temp_sum=0 && temp_multiplier=1 && continue;

		temp_sum=$(( ($center * $temp_multiplier) + $temp_sum))	
		let temp_multiplier*=10;

		top=${previous_line: $char_counter:1}
		bottom=${next_line: $char_counter:1}

		if [[ "$char_counter" -eq 0 ]]; then
			left=""
			top_left=""
			bottom_left=""
		fi # this if block is there to make sure left is getting cleaned if it's on the left edge

		if [[ "$char_counter" -ne 0 ]]; then
			left=${current_line: $char_counter-1:1}
			top_left=${previous_line: $char_counter-1:1}
			bottom_left=${next_line: $char_counter-1:1}
		fi

		if [[ "$char_counter" -ne $line_length-1 ]]; then
			right=${current_line: $char_counter+1:1}
			top_right=${previous_line: $char_counter+1:1}
			bottom_right=${next_line: $char_counter+1:1}
		fi

		# check right digits
		if [[ ! "$right" =~ $re && ! -z "$right" ]]; then
			[[ "$right" != "." && ! -z "$right" ]] || [[ "$top_right" != "." && ! -z "$top_right" ]] || [[ "$bottom_right" != "." && ! -z "$bottom_right" ]] && will_add=true;
		fi

		# check up and down
		[[ "$top" != "." && ! -z $top ]] || [[ "$bottom" != "." && ! -z $bottom ]] && will_add=true;

		# if left is a number, move on
		[[ "$left" =~ $re && ! -z "$left" ]] && continue;

		# check left if left is not a number
		if [[ ! -z "$left" ]]; then
			[[ "$left" != "." && ! -z "$left" ]] || [[ "$top_left" != "." && ! -z "$top_left" ]] || [[ "$bottom_left" != "." && ! -z "$bottom_left" ]] && will_add=true;
		fi


		if [[ "$will_add" = true ]]; then
			let parts_sum+=$temp_sum
		fi


		will_add=false
		let temp_sum=0
		let temp_multiplier=0
	done
	let counter+=1
done

echo $parts_sum
