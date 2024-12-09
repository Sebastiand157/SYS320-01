. (Join-Path $PSScriptRoot Scrape.ps1)

$FullTable = daysTranslator(gatherClasses)

# List all the classes of Instructor Furkan Paligu
$FullTable | Select "Class Code", "Title", Instructor, Location, Days, "Start Time", "End Time" | `
            Where{ $_."Instructor" -ilike "Furkan Paligu" }