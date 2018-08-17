###  Title: 
###   Windows Host File to CSV
###
###  Description:
###   Read Windows host file into CSV file for auditing purposes catching #, carriage returns and multiple hostnames
### 
###  Version:
###   2.0
###
###  Author:
###   Guy Wood (guy@guywood.eu)

# Variables
$hostFilePath = "$pwd\hostfile_to_csv"
$hostFile = "hosts_example"
$csvFile = "hosts.csv"

# Read file
$content = Get-Content "$hostFilePath\$hostFile"

# New class defined for "hosts" where one ip can have multiple possible hostnames + they relate
Class hostClass {
    [String]$ip
    [String[]]$hostname
}

# New array for loop below
$hostFileArray = @()

# Loop through removing line starting with #, blank lines and anything on a line after a #
ForEach ($line in $content) {
    if ($line[0] -ne "#" -and $line.length -gt 1) {
        $hostFileArray += $line.Split('#')[0]
    }
}

# New array for loop below to house data in CSV exportable format
$csvObj = @()

# Loop through performing various tasks detailed below
ForEach ($line in $hostFileArray) {
    # Split each line into its own array and store in $newline whilst in the loop.  Also get length ($len)
    $newLine = $line -split '\s' -match '\S'
    $len = $newLine.GetUpperBound(0)
    
    # Use hostEntry object defined by hostClass to store ip and one or more hostnames in $hostEntry whilst in the loop
    $hostEntry = New-Object hostClass 
    $hostEntry.ip = $newLine[0]
    $hostEntry.hostname = $newLine[1..$len] 

    # Loop through all hostnames storing their hostname and associated ip in an PSObject then append to $csvObj
    ForEach ($hn in $hostEntry.hostname) {
        $csvLine = New-Object PSObject
        $csvLine | Add-Member -type NoteProperty -Name 'ip' -Value $hostEntry.ip
        $csvLine | Add-Member -type NoteProperty -Name 'hostname' -Value $hn
        $csvObj += $csvLine
    }
}

# Check if file exists
If (Test-Path "$hostFilePath\$csvFile") 
{
    # Ask what user wants to do
    $proceed = Read-Host "$csvFile already exists, do you want overwrite (y)?  Or any other key to exit."

    # If overwrite...
    If ($proceed -eq "y")
    {
        # then run out-file which will auto-overwrite
        $csvObj | Export-Csv -Path $hostFilePath\$csvFile -NoTypeInformation 
    }
    # Otherwise break from loop
    Else 
    {
        break
    }
}
# If csv doesn't already exist then run out-file
Else 
{
    $csvObj | Export-Csv -Path $hostFilePath\$csvFile -NoTypeInformation 
}
