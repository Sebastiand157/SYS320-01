#Part 4

$chrome = Get-Process | Where-Object {$_.name -ilike "Chrome"}
if($chrome -eq $null) {
Start-Process -FilePath chrome.exe 'https://champlain.edu'
}
else {
Stop-Process -name chrome
}
