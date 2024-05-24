#!/bin/bash

# login & sign in {

read -p "Welcome to Pet Friendly clinic! Please provide us with your name: " name

if  grep -q "$name" logins.txt; then # if already registered user, ask for password
	echo -n "Hello, $name! Please enter your password to sign in: " 
	stored_pass=$(grep "^$name : " logins.txt | cut -d':' -f2 | xargs)
	for ((i = 0; i < 3; i++)); do # provide 3 chances to enter correct password
		read pass
		if [ "$pass" = "$stored_pass" ]; then
			echo "Login successful."
			break
		else 
			if [ "$i" != 2 ]; then
			echo -n "Incorrect password, please try again: "
			fi
		fi
	done
	if [ "$i" -eq 3 ]; then # if all 3 chances failed, exit the program
		echo "You have exceeded the number of allowed trials, exiting the program..."
		exit 1
	fi
else # if a new user, ask for password to register them
	echo -n "Hello, $name! You are a new user. Please enter your password to complete the regiteraion process: "
	read pass
	echo "$name : $pass" >> logins.txt
	printf "\n\n$name [ 0 ] :" >> appointments.txt
	echo "Registeration complete!"
fi

# } end of login & sign in

# printf "" > receipt.txt # receipt.txt serves as a buffer to store requested services by the user

# provide services to user {
ext=0
until [ $ext -ne 0 ]; do # loop to enable the user to select multiple services

printf "\nPlease choose one of the following services by entering its number: \n\n"
cat services.txt
read ch
echo " "

while [ $ch -lt 1 ] || [ $ch -gt 14 ] 2> /dev/null; do # troubleshoot for invalid entries
	read -p "Please enetr a valid number: " ch
done

if [ $ch -ge 1 ] && [ $ch -le 4 ]; then
	printf "" #  Clinik services
	./services.sh $name $ch

elif [ $ch -le 9 ]; then
	printf "" # Home services

else
	num=$(grep -w "$name" appointments.txt | cut -d " " -f 3)

	show_appoint(){
                 flag=0
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

	


	case $ch in
		"10") # do something
		;;

		"11")
			show_appoint
		;;

		"12") # //
			echo "Please choose the appointment you want to cancel by entering its number: "
			show_appoint
			read cancel
			echo " "

			flag=0
			while [ $cancel -lt 1 ] || [ $cancel -gt $count ]; do
				echo "You entered an invalid number, do you want to return to main menue?"
				read -p "Enter \"Y\" for yes or \"N\" for no: " ret
				if [ $ret == "Y" ] || [ $ret  == "y" ]; then
					flag=1
					break
				fi
				read -p "Please enter a valid number: " cancel
			done

			if [ $flag -eq 0 ]; then


				if [ $cancel -le $num ]; then
					sed -i "s/$name \[ $num \]/$name \[ $(($num-1)) \]/" appointments.txt
					del=$(grep -A $num "$name" appointments.txt | awk 'END {print}' )
					sed -i "/$del/d" appointments.txt
				else
					del=$(awk "NR == $((cancel-num)) {print}" receipt.txt)
					sed -i "/$del/d" receipt.txt
				fi
				printf "Your appointment has been canceled successfully upon your request\n\n"
			fi
		;;

		"13") # //
		;;

		"14")
			ext=1
		;;
	esac

fi

if [ $ch -ne 14 ]; then
	printf "\nWould you like another service?\n"
	read -p "Enter \"Y\" for yes or \"N\" for no: " ans

	if [ $ans != "Y" ] && [ $ans  != "y" ]; then
		ext=1
	fi
fi

done
# } end of services providing

# payment {
		# calc total here


printf "Would you like to pay with:\n1-Cash\n2-Credit Card\n"
read pay

while [ $pay -ne 1 ] && [ $pay -ne 2 ] 2> /dev/null; do
	read -p "Please enter a valid number: " pay
done

case $pay in

	"1")
		echo "You would be able to pay once you recieve the service"
	;;

	"2")
		read -p "please enter your card number: " cardNum
		read -p "Please enter the name on the card: " cardName
		read -p "please enter the expiration date of the card in this format YY/MM: " cardDate

		printf "\nThe payment process has been completed successfully\n"
	;;
esac

echo "Thank you for choosing our clinic. Hava a nice day!"

# } end of payment

# confirming the payment process by moving the
# services from "receipt.txt" to "appointments.txt" {

while read line; do
        sed -i "/$name /a\
$line" appointments.txt
done < receipt.txt

# } end of moving

