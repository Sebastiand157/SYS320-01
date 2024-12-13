<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}
function checkPassword($password){
    if($password.length -lt 6){
    return $false
    }
    elseif($password -inotlike "*[0-9]*"){
    return $false
    }
    elseif($password -inotlike "*[a-zA-Z]*"){
    return $false
    }
    elseif($password -inotlike "*[^A-Za-z0-9]*"){
    return $false
    }
    else{
    return $true
    }
}

checkPassword "seb157!"

