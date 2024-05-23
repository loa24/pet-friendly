#!/bin/bash

# login & sign in {

read -p "Welcome to Pet Friendly clinic! Please provide us with your name: " name

if  grep -q "$name" logins.txt; then
	echo -n "Hello, $name! Please enter your password to sign in: " 
	stored_pass=$(grep "^$name : " logins.txt | cut -d':' -f2 | xargs)
	for ((i = 0; i < 3; i++)); do
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
	if [ "$i" -eq 3 ]; then
		echo "You have exceeded the number of allowed trials, exiting the program..."
		exit 1
	fi
else
	echo -n "Hello, $name! You are a new user. Please enter your password to complete the regiteraion process: "
	read pass
	echo "$name : $pass" >> logins.txt
	echo "Registeration complete!"
fi

# } end of login & sign in


printf "\nPlease choose one of the following services by entering its number: \n\n"
cat services.txt
read ch

while [ $ch -lt 1 ] || [ $ch -gt 12 ] 2> /dev/null; do
	read -p "Please enetr a valid number: " ch
done

if [ $ch -ge 1 ] && [ $ch -le 4 ]; then
	printf "" #  Clinik services

elif [ $ch -le 9 ]; then
	printf "" # Home services

else
	num=$(grep '$name' appointments.txt | cut -d " " -f 3)

	case $ch in
		"10") # do something
		;;

		"11")
			flag=0
			if [ $num -ne 0 ]; then
				echo "Payed appointments:"
				grep -A 2 '$name' appointments.txt | awk 'NR > 1'
				flag=1
			fi
			echo " "

			if [ -s "receipt.txt" ]; then
				echo "Unpayed appointments:"
				count=$num
				while read line; do
					count=$((count + 1))
					echo "$num) $line"
				done < receipt.txt
				flag=1
			fi
			echo " "

			if [ "$flag" -eq 0 ]; then
				echo "You have no appointments yet."
			fi
			echo " "
		;;

		"12") # //
		;;

		"13") # //
		;;
	esac

fi
