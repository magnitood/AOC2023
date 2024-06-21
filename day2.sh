#part 1

cat in2.txt | tr '[:;,]' '\n' | awk 'BEGIN {game=0} /Game/ {sum+=game; game=$2} /red/ {if ($1 > 12) game = 0} /green/ {if ($1 > 13) game = 0;} /blue/ {if ($1 > 14) game = 0} END {sum += game; print sum}'

#part 2

cat in2.txt | tr '[:;,]' '\n' | awk ' BEGIN {r=0; g=0; b=0;} /Game/ {sum+=r*g*b; r=0; g=0; b=0;} /red/ {if ($1 > r) r=$1} /green/ {if ($1 > g) g=$1} /blue/ {if ($1 > b) b=$1} END {sum+=r*g*b; print sum}'
