#!/bin/bash

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

