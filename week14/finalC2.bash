logFile="$1"
ioc="$2"

cat "$logFile" | egrep -i -f "$ioc" | cut -d ' ' -f 1,4,7 | tr -d '[' \
 > report.txt
