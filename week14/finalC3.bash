reportFile=report.txt
echo "<html>" > /var/www/html/report.html
apacheFile=/var/www/html/report.html
echo "  <body>" >> "$apacheFile"
echo "    Access logs with IOC indicators:" >> "$apacheFile"
echo "    <br>" >> "$apacheFile"
echo "    <table>" >> "$apacheFile"
echo "    <tbody>" >> "$apacheFile"
while read -r line
do
echo "      <tr>"
echo "<td>"
echo "$line" | cut -d " " -f 1;
echo "</td>"
echo "<td>"
echo "$line" | cut -d " " -f 2;
echo "</td>"
echo "<td>"
echo "$line" | cut -d " " -f 3;
echo "</td>"
echo "      </tr>"
done <"$reportFile" >> "$apacheFile"
echo "    </tbody>" >> "$apacheFile"
echo "    </table>" >> "$apacheFile"
echo "  </body>" >> "$apacheFile"
echo "</html>" >> "$apacheFile"
