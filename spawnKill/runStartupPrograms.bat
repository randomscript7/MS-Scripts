REM This batch file is set to run two PowerShell scripts: processCatcher.ps1 and killProcesses.ps1

REM Initial delay to let the system stabilize after startup
timeout /t 60 /nobreak >nul

REM processCatcher.ps1 captures and logs currently running processes as defined in USERENV:heavyProcesses.txt
powershell.exe -ExecutionPolicy Bypass "C:\DIRECTORY-TO\processCatcher.ps1"

REM killProcesses.ps1 terminates processes found with processCatcher.ps1
REM powershell.exe -ExecutionPolicy Bypass "C:\DIRECTORY-TO\killProcesses.ps1"
REM Currently commented out for processes can be killed manually