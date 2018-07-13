# HostfileToCSV
PowerShell script that converts Windows hostfile into CSV 

# v1.0

Takes a Windows host file and converts it into CSV format using Powershell.
Host file must be copied from C:\Windows\System32\drivers\etc into the project directory.
CSV file will be dropped to the same directory.
The script handles multiple (hopefully all) possible variances in host file formatting

Files:
host_example              Example host files with fake records
hostfile_to_csv.ps1       Script

# Future enhancements

- Addition of extra row in CSV where IP has multiple associated hostnames
- Remote script execution across multiple systems consolidating CSV
- Removal of duplicate records in CSV where ip/hostname are identical
