# Logfile of chosen programs to watch for, along with their PIDs
$logFile = "$env:USERPROFILE\capturedPids.txt"

# Get the PIDs from the logfile and terminate them
Get-Content $logFile | ForEach-Object {

    if ($_ -match "Process:\s+([^\-]+)\s+-\s+Instances:\s+(\d+)\s+-\s+PIDs:\s+(.+)$") {
        $processName = $Matches[1].Trim()
        $pids = $Matches[3] -split ",\s*"
        
        # SIGINT all of them, presenting error if there's a failure
        foreach ($PIDvalue in $pids) {
            try {
                Stop-Process -Id $PIDvalue -ErrorAction Stop
                Write-Host "Requested SIGINT for Process $processName with PID $PIDvalue"
            } catch {
                Write-Host "SIGINT FAILED for PID ${PIDvalue}: $_"
            }
        }
    } else {
        Write-Host "No valid process entry found in line: $_"
    }
}