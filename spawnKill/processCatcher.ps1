# ----------------------------------------------------------
# Place this file in your startup folder to run at login
# ----------------------------------------------------------

# Monitor for processes and log their PID when it starts, putting them in a file
$logFile = "$env:USERPROFILE\capturedPids.txt"

# File with process keywords
$keywordsFile = "$env:USERPROFILE\undesirableProcesses.txt"

# Initialize an array to hold process keywords, as taken from undesirableProcesses.txt file
$processKeywords = @()

# Run indefinitely, logging all chosen processes if running
while ($true) {
    
    # Load process keywords from file, ignoring lines starting with '#'
    if (Test-Path $keywordsFile) {
        $fileKeywords = Get-Content $keywordsFile | Where-Object { $_ -and -not ($_ -match '^\s*#') }
        $processKeywords += $fileKeywords
    } else {
        Write-Host "Keywords file not found: $keywordsFile"
        break
    }

    # Loop through each keyword and check if the process is running, logging if true
    forEach ($keyword in $processKeywords) {
        $proc = Get-Process -Name $keyword -ErrorAction SilentlyContinue
        if ($proc) {
            # Write-Output "Detected process: $($proc.Name)"
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $count = @($proc).Count
            Write-Output "Detected process: $keyword ($count)"
            "$timestamp - Process: $keyword - Instances: $count - PIDs: $(@($proc).Id -join ', ')" | Out-File -Append $logFile
            Start-Sleep -Seconds 5  # Avoid spamming the log
        } else {
            Write-Host "Process '$keyword' not running, skipped"
        }
    }

    Write-Host "-------------------------------"
    Start-Sleep -Seconds 15 # 15 second delay before next check, to be light on the cpu
    Clear-Host
    Clear-Content -Path $logFile
}
