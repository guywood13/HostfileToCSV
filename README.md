# HostfileToCSV
PowerShell script that converts Windows hostfile into CSV 

# v2.0

Re-write using loops instead of regex for better control.
Same functionality as v1.0 with addition of multiple rows where ip has multiple hostnames

Files:
1. host_example - Example host files with fake records (updated slightly for testing)
2. hostfile_to_csv_v2.0.ps1 - Script

# v1.0

Takes a Windows host file and converts it into CSV format using Powershell.
Host file must be copied from C:\Windows\System32\drivers\etc into the project directory.
CSV file will be dropped to the same directory.
The script handles multiple (hopefully all) possible variances in host file formatting.

Files:
1. host_example - Example host files with fake records
2. hostfile_to_csv_v1.0.ps1 - Script

# Future enhancements

~~- Addition of extra row in CSV where IP has multiple associated hostnames~~
- Remote script execution across multiple systems consolidating CSV
- Removal of duplicate records in CSV where ip/hostname are identical
