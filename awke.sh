


grep -A 4 -i 'jana' appointments.txt | awk '{
if ( NR == 1) {
print $0
}
else {
print NR - 1")", $0
}
}'

grep -A 4 -i 'jana' appointments.txt | awk '{ if ( NR == 1) { print $0 } else { print NR - 1")", $0 } }'


num=2

printf "\n\n\n"
awk -v num=$num '{ print NR + num")" $0 }' receipt.txt 
