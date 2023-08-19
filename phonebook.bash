#!/bin/bash

#read -p "Enter" :
#read -p $1

if [ "$*" == "" ]
then
echo "-i	Insert new contact name and number"
echo "-v	View all saved contacts details"
echo "-s	Search by contact name in the phonebook database"
echo "-e	Delete all records"
echo "-d	Delete one contact name"
fi

if [ "$1" == "-i" ]
then
read -p "Enter Contact Name : " Contact_Name
echo "$Contact_Name" | grep -q '[A-Za-z ]'
if [[ -n ${Contact_Name//[A-Z-a-z ]} ]]
then
echo "Invalid input name"
echo "name should contains letters"
else
read -p "Enter Contact Number : " Contact_Number
echo "$Contact_Number" | grep -q '[0-9]'
if [[ -n ${Contact_Number//[0-9]} ]]
then
echo "Invalid input number"
echo "number should contains numbers [0-9]"
else
echo $Contact_Name $Contact_Number >>  file.txt
echo "Contact has been saved successfully"
fi
fi
fi

if [ "$1" == "-v" ]
then
if [ -s file.txt ]
then
echo "phonebook list : "
cat file.txt
else
echo "phonebook is empty"
fi
fi

if [ "$1" == "-s" ]
then
echo "Search a Contact"
read -p "Enter Contact Name : " Contact_Name
if grep "$Contact_Name" file.txt
then echo "FOUND"
else echo "NOT FOUND"
fi
fi

if [ "$1" == "-e" ]
then  > file.txt
echo "All Records have been deleted"
fi

#if [ "$1" == "-d" ]
#then
#echo "Delete a contact"
#read -p "Enter Contact Name : " Contact_Name
#if grep "$Contact_Name" file.txt
#then echo "Contact is found"
#read -p "press enter to delete"
#sed -i "/$Contact_Name/d" file.txt
#sed '/^$/!d' file.txt
#else echo "Contact is not Found"
#fi
#fi

if [ "$1" == "-d" ]
then
echo "Delete a contact"
read -p "Enter Contact Name : " Contact_Name
	if grep "$Contact_Name" file.txt  ## to check if there is a contact with that pattern
	then
		if [ $(grep -r  "$Contact_Name" file.txt | wc -l) -gt 1 ] ## to check if there is more than one pattern
		then
		echo "warning!! more than one contact with the same pattern"
		read -p "press enter to delete or ^c to exit"
		sed -i "/$Contact_Name/d" file.txt
		sed '/^$/!d' file.txt
		echo "Contacts have been deleted"
		else
		echo "Contact has been found"
		read -p "press enter to delete or ^c to exit"
		sed -i "/$Contact_Name/d" file.txt
		sed '/^$/!d' file.txt
		echo "Contact have been deleted"
		fi
	else
	echo "Contact Not Found"
	fi
fi
