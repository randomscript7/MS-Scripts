#Incredibly simple script to list basic hardware information

#List RAM in GB, type of memory, and the manufacturer
#List CPU name, processors and cores
#List disk space and how much is free

# Get CPU information
$cpu = Get-WmiObject Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed

# Get RAM information
$ram = Get-WmiObject Win32_PhysicalMemory | Select-Object @{Name ="Capacity, GB"; Expression = {$_.Capacity / 1GB}}, Manufacturer

# Get Disk Space information and round to the nearest gigabyte
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | Select-Object DeviceID, @{Name="Size (GB)"; Expression = {[math]::Round($_.Size / 1GB)}}, @{Name="FreeSpace (GB)"; Expression = {[math]::Round($_.FreeSpace / 1GB)}}

# Output CPU information
Write-Host "CPU Information:"
Write-Host "--------------------"
$cpu | Format-Table -AutoSize

# Output RAM information
Write-Host "RAM Information:"
Write-Host "--------------------"
$ram | Format-Table -AutoSize

# Output Disk Space information
Write-Host "Disk Space Information:"
Write-Host "--------------------"
$disk | Format-Table -AutoSize