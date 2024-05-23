#!/bin/bash

# Function to report an animal in need
report_animal_in_need() {
    # Prompt user for their name and read input
    echo "Please enter your name:"
    read name
    
    # Prompt user for pet description and read input
    echo "Please enter the pet description:"
    read description
    
    # Prompt user for the location they found the pet and read input
    echo "Please enter the location where you found the pet:"
    read location
    
    # Save the report to a file
    echo "Name: $name" >> animal_reports.txt
    echo "Description: $description" >> animal_reports.txt
    echo "Location: $location" >> animal_reports.txt
    echo "------------------------" >> animal_reports.txt
    
    # Display the report
    echo "Thank you for your report. The information has been saved."
}

# Run the report function
report_animal_in_need
