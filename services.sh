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
chosen_service=$(grep "^$service_number)" services.txt | cut -d ")" -f 2 | cut -d "(" -f 1)
chosen_service=${chosen_service:1:-1}

service_price=$(grep "^$service_number" services.txt | cut -d "(" -f 2)
service_price=${service_price:1:2}

# Prompt the user for the appointment date
read -p "Enter the date of your appointment (YYYY-MM-DD): " appointment_date

# Save the appointment information to a receipt file
echo "$chosen_service, $appointment_date, ( $service_price SAR )" >> receipt.txt

# Print the selected service and appointment date
echo "You have selected '$chosen_service' (Price: $service_price SAR) on $appointment_date."

echo "Thank you for using our services!"
