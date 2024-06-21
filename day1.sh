#!/bin/bash

cat in1.txt | sed -E 's/(one)/\11\1/g; s/(two)/\12\1/g; s/(three)/\13\1/g; s/(four)/\14\1/g; s/(five)/\15\1/g; s/(six)/\16\1/g; s/(seven)/\17\1/g; s/(eight)/\18\1/g; s/(nine)/\19\1/g;' | tr -d 'a-zA-Z' | awk -F '' '{ sum += $1$NF } END {print sum}'

