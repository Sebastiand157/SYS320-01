function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.12/Courses-1.html

# Get all the tr elements of HTML document
$trs=$page.ParsedHtml.body.getElementsByTagName("tr")

# Empty array to hold results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ # Going over every tr element

    # Get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")

    # Want ot separate start time and end time from one time field
    $Times = $tds[5].innerText.split("-")

    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText;
                                    "Title"      = $tds[1].innerText;
                                    "Days"       = $tds[4].innerText;
                                    "Time Start" = $Times[0];
                                    "Time End"   = $Times[1];
                                    "Instructor" = $tds[6].innerText;
                                    "Location"   = $tds[9].innerText;
                                    }
}
return $FullTable
} 
