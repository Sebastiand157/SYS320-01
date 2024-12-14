#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function DisplayCoursesOfInst() {

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function DisplayCourseCountOfInsts() {

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

function DisplayCoursesOfAClass() {
	echo "Enter a building location followed by the room number (ex. JOYC 310)"
 #If you enter just a building it will show all the classes in that building :)
	read room

	room=$(echo "$room" | sed 's/-/ /g')

	echo "Classes in $room"
	cat "$courseFile" | grep "$room" | cut -d';' -f1,2,5,6,7 | \
	sed 's/;/ | /g'
	echo ""
}

function DisplayAvailCoursesOfSub() {
	echo "Enter a course code to check please! (Ex:SEC)"
	read courseCode

	echo "Available courses in $courseCode :"
	cat "$courseFile" | grep "$courseCode" | while read -r line;
	do
		if (( $(echo "$line" | cut -d';' -f4) > 0 )); then
			echo "$line" | sed 's/;/ | /g'
		fi
	done
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display available courses of subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		DisplayCoursesOfInst

	elif [[ "$userInput" == "2" ]]; then
		DisplayCourseCountOfInsts

	elif [[ "$userInput" == "3" ]]; then
		DisplayCoursesOfAClass

	elif [[ "$userInput" == "4" ]]; then
		DisplayAvailCoursesOfSub

	else
		echo "The input you entered was not valid. Please try again"
	fi
done
