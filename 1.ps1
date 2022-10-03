# Set Command Descriptive Text in Cyan

$CommandDesc = " -ForegroundColor Cyan"



function CMDColour($text){

    invoke-expression ("Write-Host " + $text + $CommandDesc)

}



$cmdList =  

	@("", "The following section contains commands that remove Active Setup Registry entries. These optimisations are aimed at reducing logon times.", "sectioncomplete"),

     ("Deleting StubPath - Themes Setup.","'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{2C7339CF-2B09-4501-B3F3-F3508C9228ED}' /v StubPath /f", "delete"),

     ("Deleting StubPath - WinMail.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}' /v StubPath /f", "delete"),

     ("Deleting StubPath x64 - WinMail.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\{44BBA840-CC51-11CF-AAFA-00AA00B6015C}' /v StubPath /f", "delete"),

     ("Deleting StubPath - Windows Media Player.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{6BF52A52-394A-11d3-B153-00C04F79FAA6}' /v StubPath /f", "delete"),

     ("Deleting StubPath x64 - Windows Media Player.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\{6BF52A52-394A-11d3-B153-00C04F79FAA6}' /v StubPath /f", "delete"),

     ("Deleting StubPath - Windows Desktop Update.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{89820200-ECBD-11cf-8B85-00AA005B4340}' /v StubPath /f", "delete"),

     ("Deleting StubPath - Web Platform Customizations.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\{89820200-ECBD-11cf-8B85-00AA005B4383}' /v StubPath /f", "delete"),

     ("Deleting StubPath - Windows Media Player.", "'HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\>{22d6f312-b0f6-11d0-94ab-0080c74c7e95}' /v StubPath /f", "delete"),

     ("Deleting StubPath x64 - Windows Media Player.", "'HKLM\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\>{22d6f312-b0f6-11d0-94ab-0080c74c7e95}' /v StubPath /f", "delete"),

     ("", "The following section contains commands that add or modify various Registry entries to the system. These optimisations are aimed at improving system performance. Many of these optimisations are the same ones you get when running the PVS 7.11 Target Device Optimization Tool with the exception of HKCU optimizations. Optimizations made by importing HKCU registry entries should be created via Group Policy or Citrix WEM.", "sectioncomplete"),

     ("Creating EnableAutoLayout DWORD - Disable Background Layout Service.", "'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout' /v EnableAutoLayout /t REG_DWORD /d 0x0 /f", "add"),

     ("Creating DumpFileSize DWORD - Reduce DedicatedDumpFile DumpFileSize to 2 MB.", "'HKLM\SYSTEM\CurrentControlSet\Control\CrashControl' /v DumpFileSize /t REG_DWORD /d 0x2 /f", "add"),

     ("Creating IgnorePagefileSize DWORD - Reduce DedicatedDumpFile DumpFileSize to 2 MB.", "'HKLM\SYSTEM\CurrentControlSet\Control\CrashControl' /v IgnorePagefileSize /t REG_DWORD /d 0x1 /f", "add"),

     ("Adding DisableLogonBackgroundImage DWORD - Disable Logon Background Image.", "'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v DisableLogonBackgroundImage /t REG_DWORD /d 0x1 /f", "add"),

     ("Changing TimeoutValue DWORD from 0x41 to 0xC8 - Increase Disk I/O Timeout to 200 seconds .", "'HKLM\SYSTEM\CurrentControlSet\Services\Disk' /v TimeoutValue /t REG_DWORD /d 0xC8 /f", "add"),

     ("", "The following section contains a command that removes the Windows Defender feature. This action also removes Scheduled Tasks and services relating to Windows Defender. This optimisation is based on the assumption that another antivirus will be used to replace Windows Defender.", "sectioncomplete"),

	 ("Removing WindowsFeature Windows-Defender-Features", "Windows-Defender-Features", "Remove-WindowsFeature");



Foreach ($cmd in $cmdList) {



	# Print description of change

	CMDColour $cmd[0]



	#Identify type of change

	switch($cmd[2]) {

	

        "sectioncomplete"

            {

                Write-Host $cmd[1] -ForeGroundColor Green

                Invoke-Expression $Pausefor5Secs

            }		



        "delete" # The following "reg delete" section will run commands that remove Active Setup Registry entries. These optimisations are aimed at reducing logon times.

			{

				Write-Host "reg delete" $cmd[1]

				Invoke-Expression ("reg delete " + $cmd[1])



                Invoke-Expression $Pausefor2Secs

			}

			

		"add" # The following section contains commands that add various Registry entries to the system. These optimisations are aimed at improving system performance. Many of these optimisations are the same ones you get when running the PVS 7.11 Target Device Optimization Tool with the exception of HKCU optimizations. Optimizations made by importing HKCU registry entries should be created via Group Policy or Citrix WEM.

              # Optimisations that the Target Device Optimization Tool makes but are left out in this script:

              # - Disable Indexing Service - Redundant, replaced by Windows Search. Windows Search not installed by default on WS2016.

              # - Disable Windows SuperFetch service - This service is set to be disabled already further down this script.

              # - Disable Windows Search - Windows Search is not installed by default on WS2016.

			{

				Write-Host "reg add" $cmd[1]

				Invoke-Expression ("reg add " + $cmd[1])



                Invoke-Expression $Pausefor2Secs

			}

	

		"set-service" # The following "Set-Service" section will run commands that disable services. These optimisations are aimed at reducing system footprint and improving performance.

			{

				Write-Host "Set-Service" $cmd[1]

				Invoke-Expression ("Set-Service " + $cmd[1])



                Invoke-Expression $Pausefor2Secs

			}

	

		"Disable-ScheduledTask" #The following "Disable ScheduledTask" section will run commands that Scheduled Tasks. These optimisations are aimed at reducing system footprint and improving performance.

			{

				Write-Host "Disable-ScheduledTask" $cmd[1]

				Invoke-Expression ("Disable-ScheduledTask " + $cmd[1])



                Invoke-Expression $Pausefor2Secs

			}

			

		"Remove-WindowsFeature" # The following "Remote-WindowsFeature" section will run a command that removes the Windows Defender feature. This action also removes Scheduled Tasks and services relating to Windows Defender. This optimisation is based on the assumption that another antivirus will be used to replace Windows Defender.

			                    # Windows Scheduled Tasks removed after removal of Windows Defender:

                                # - Windows Defender Cache Maintenance

                                # - Windows Defender Cleanup

                                # - Windows Defender Scheduled Scan

                                # - Windows Defender Verification

                                # Windows services removed after removal of Windows Defender:

                                # - Windows Defender Network Inspection Service

                                # - Windws Defender Service

            {

				Write-Host "Remove-WindowsFeature" $cmd[1]

				Invoke-Expression ("Remove-WindowsFeature " + $cmd[1])

			}

			

	} # End of Switch

} # End of Foreach


Write-Host "All optimisations complete. Please restart your system." -ForegroundColor Green
