###  Title: 
###   Windows Host File to CSV
###
###  Description:
###   Read Windows host file into CSV file for auditing purposes catching #, carriage returns and multiple hostnames
### 
###  Version:
###   1.0
###
###  Author:
###   Guy Wood (guy@guywood.eu)

# Variables
$hostfilepath = "$pwd\hostfile_to_csv"
$hostfile = "hosts_example"
$csvfile = "hosts.csv"

# Read file
$content = Get-Content "$hostfilepath\$hostfile"

# Catch only lines starting with a number
$newcontent = $content -match "^[0-9].*"

# Remove comments which start with #
$newcontentnocomms = $newcontent -replace "[#].*", ""

# Replace whitespace with commas
$delimitedcontent = $newcontentnocomms -replace '[ \t]',','

# Remove duplicate commas in sequence and commas at the eol 
$tidydelimitedcontent = $delimitedcontent -replace '(?m),(?=,|$)', ''

# If csv already exists...
If (Test-Path "$hostfilepath\$csvfile") 
{
    # Ask what user wants to do
    $Proceed = Read-Host "$csvfile already exists, do you want overwrite (y)?  Or any other key to exit."
    # If overwrite...
    If ($Proceed -eq "y")
    {
        # then run out-file which will auto-overwrite
        $tidydelimitedcontent | Out-File "$hostfilepath\$csvfile" -Encoding ascii 
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
    $tidydelimitedcontent | Out-File "$hostfilepath\$csvfile" -Encoding ascii
}