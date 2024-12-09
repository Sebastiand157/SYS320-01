function gatherClasses() {

    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.12/Courses-1.html

    # Get all the tr elements of HTML document
    $trs=$page.ParsedHtml.body.getElementsByTagName("tr")

    # Empty array to hold results
    $FullTable = @()
    for ($i=1; $i -lt $trs.length; $i++) { # Going over every tr element

        # Get every td element of current tr element
        $tds = $trs[$i].getElementsByTagName("td")

        # Want to separate start time and end time from one time field
        $Times = $tds[5].innerText.split("-")

        $FullTable += [pscustomobject]@{"Class Code"  = $tds[0].innerText; `
                                        "Title"       = $tds[1].innerText; `
                                        "Days"        = $tds[4].innerText; `
                                        "Start Time"  = $Times[0]; `
                                        "End Time"    = $Times[1]; `
                                        "Instructor"  = $tds[6].innerText; `
                                        "Location"    = $tds[9].innerText;
                                        }

} # end of for loop
return $FullTable
}



function daysTranslator($FullTable){
for($i=0; $i -lt $FullTable.length; $i++){
    $Days = @()
        if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }
        if($FullTable[$i].Days -ilike "*T[FTW]*"){ $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }
        if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }
        if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }
        $FullTable[$i].Days = $Days
}
return $FullTable
}

#$result = gatherClasses
#$result

#$DayTable = daysTranslator $result
#$DayTable
