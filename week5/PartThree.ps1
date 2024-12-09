﻿. (Join-Path $PSScriptRoot .Scrape.ps1)

# Make a list of all the instructors that teach at least 1 course in
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique

$ITSInstructors = $FullTable | where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                             | sort-Object "Instructor" `
                             | select "Instructor" -Unique
$ITSInstructors








