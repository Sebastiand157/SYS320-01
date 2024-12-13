clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate it to champlain.edu`n"
$Prompt += "5 - Exit`n"

# 'n is for line breaks in a string

$operation = $true # Starting with true to enter the loop

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false
    }

    elseif($choice -eq 4){

            # Define the process name for Google Chrome
        $chromeProcessName = "chrome"

        # Check if Google Chrome is running
        $chromeProcess = Get-Process -Name $chromeProcessName -ErrorAction SilentlyContinue

        if ($chromeProcess -eq $null) {
            # If Chrome is not running, start it and navigate to champlain.edu
            Start-Process "chrome.exe" "https://www.champlain.edu"
            Write-Host "Google Chrome started and directed to champlain.edu."
        } 
        
        else {
            # If Chrome is running, stop all instances of it
            Stop-Process -Name $chromeProcessName -Force
            Write-Host "Google Chrome is running and has been stopped."
        }
   
    }

    elseif($choice -eq 3){
         $failList = @()
        $userLogins = getFailedLogins
        if($userLogins.count -le 0){
            Write-Host "No at risk users in the past $days days" | Out-String
    }
    }

    elseif($choice -eq 2){
        $userLogins = getFailedLogins $days
        Write-Host ($userLogins | Select -First 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 1){
        Get-Content C:\xampp\apache\logs\access.log -Tail 10 | Out-String
    }

    else{
    Write-Host "Invalid input. Please try again."
     }   
    

} 


