#!/bin/bash

# Services file path
services_file="services.txt"

# Get the arguments
user_name=$1
service_number=$2

# Check if the services file exists
if [ ! -f "$services_file" ]; then
    echo "Services file '$services_file' not found."
    exit 1
fi

# Read the service name and price from the file
chosen_service=$(awk -v num="$service_number" '$1 == num {print $2}' "$services_file")
service_price=$(awk -v num="$service_number" '$1 == num {print $3}' "$services_file")
# Prompt the user for the appointment date
read -p "Enter the date of your appointment (YYYY-MM-DD): " appointment_date

# Save the appointment information to a receipt file
echo "Chosen Service: $chosen_service" >> receipt.txt
echo "Service Price: $service_price SAR" >> receipt.txt
echo "Appointment Date: $appointment_date" >> receipt.txt
echo "------------------------" >> receipt.txt

# Print the selected service and appointment date
echo "You have selected '$chosen_service' (Price: $service_price SAR) on $appointment_date."

# Ask the user if they want to add more services
read -p "Do you want to add more services? (y/n) " add_more

# If the user wants to add more services, loop back to the beginning
if [ "$add_more" = "y" ]; then
    ./services.sh "$user_name"
else
   echo "Thank you for using our services!"
fi
