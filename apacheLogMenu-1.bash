#! /bin/bash

logFile="/var/log/apache2/access.log.1"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
	cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '[' | sort \
				| uniq)
		:> newtemp.txt
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
				| cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d " " -f 1)

		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done
	cat "newtemp.txt" | sort -n | uniq -c
}

function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort -n | uniq -c
}

function FrequentVisitors(){
	FreqV=$(histogram)
	:> newtemp1.txt
	echo "$FreqV" | while read -r line;
	do
		local IPCount=$(echo "$line" | cut -d " " -f 1)
		local IP=$(echo "$line" | cut -d " " -f 2)
		if [[ "${IPCount}" -ge "10" ]]
		then
			echo "$IPCount $IP" >> newtemp1.txt
		fi
	done
	cat "newtemp1.txt"
}

function SuspiciousVisitors(){
	cat "$logFile" | egrep -i -f ioc.txt | cut -d " " -f 1 | sort -n | uniq -c
}

while :
do

	echo "Please select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	echo "[5] Frequent Visitors"
	echo "[6] Suspicious Visitors"
	echo "[7] Quit"
	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "GoodBye"
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "3" ]]; then
		echo "Display only Pages:"
		displayOnlyPages

	elif [[ "$userInput" == "5" ]]; then
		echo "Frequent Visitors:"
		FrequentVisitors

	elif [[ "$userInput" == "6" ]]; then
		echo "Suspicious Visitors:"
		SuspiciousVisitors

	fi
done

