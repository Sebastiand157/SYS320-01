link="10.0.17.6/IOC.html"

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
xmlstarlet select --template --value-of \
"//html//body//table//tr")

echo "$toolOutput"

echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
		     sed -e 's/&amp;//g' | \
		     sed -e 's/<tr>//g' | \
	   	     sed -e 's/<td[^>]*>//g' | \
		     sed -e 's/<\/td>/;/g' | \
		     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
		     sed -e 's/<[/\]\{0,1\}nobr>//g' \
		      > readmee.txt

sed -i '/^\s*$/d' readmee.txt

awk 'NR % 2 {print} !(NR % 2) && /pattern/ {print}' readmee.txt | sed 's/\t\t*//g' | sed '1d' \
 > IOC.txt
