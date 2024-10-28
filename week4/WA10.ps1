function ApacheLogs($page,$statuscode,$browser){
$snag = Get-Content C:\xampp\apache\logs\access.log
$matchall = $snag | Select-String "$page" | Select-String $statuscode | Select-String $browser
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
$ipsUnorganized = $regex.Matches($matchall)
$accessTable = @()
for($i=0; $i -lt $matchall.count; $i++){
$accessTable += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value;
                                   "Page" = $page;
                                   "Status Code" = $statuscode;
                                   "Browser" = $browser;
                                   }
 }
return $accessTable
}
 
ApacheLogs "index.html" " 200 " "Chrome"
