﻿. (Join-Path $PSScriptRoot Scrape.ps1)

# List all the classes of JOYC 310 on Mondays, only display Class Code and Time
# Sort by Start Time
$FullTable | where-Object{ ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | `
            sort-Object "Start Time" | `
            select "Start Time", "End Time", "Class Code"