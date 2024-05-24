

testos(){
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


name="Lamar"
while read line; do
	sed -i "/$name /a\
$line" try.txt
done < receipt.txt

cat try.txt
}



	read -p "Name please: " name

        num=$(grep -w "$name" appointments.txt | cut -d " " -f 3)

        show_appoint(){

                 flag=0;
                 if [ $num -ne 0 ]; then
                         echo "Payed appointments:"
                         grep -A $num -i -w "$name" appointments.txt | awk '{ if ( NR == 1) { print $0 } else { print NR - 1")", $0 } }'

                         flag=1
                         echo " "
                 fi

                 if [ -s "receipt.txt" ]; then
                         echo "Unpayed appointments:"
                         count=$num
                         while read line; do
                                 count=$((count + 1))
                                 echo "$count) $line"
                         done < receipt.txt
                         flag=1
                         echo " "
                fi

                if [ "$flag" -eq 0 ]; then
                         echo "You have no appointments yet."
                         echo " "
                fi
        }


show_appoint
