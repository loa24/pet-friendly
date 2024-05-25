#/bin/bash
#function to report animal in need
report_animal_in_need(){

#get the users name from the argument
        name=$1

        #prompt user to get pet describtion and read input
        echo "Please enter the describtion: "
        read description

        #prompt users for the location they found the pet in and read input
        echo "Please enter the location of the found pet: "
        read location

        #save the report to a file
        echo "Name: $name">>animal_reports.txt
        echo "Description: $description">>animal_reports.txt
        echo "Location: $location">>animal_reports.txt
        echo "----------------------">>animal_reports.txt           

        #display the report
        echo "Thank you for your report, $name. The information has been saved"
}

report_animal_in_need $1
