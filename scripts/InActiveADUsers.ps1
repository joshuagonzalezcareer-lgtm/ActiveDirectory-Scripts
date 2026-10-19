# Import AD module
Import-Module ActiveDirectory

# Number of days to consider inactive
$DaysInactive = 90

# Search for inactive users
$Inactive = Search-ADAccount -AccountInactive -UserOnly -TimeSpan (New-TimeSpan -Days $DaysInactive)

# Export results to a CSV
$InactiveUsers | Select-Object Name, SamAccountName, LastLogonDate, Enabled | Export-Csv "C:\Scripts\inactive-users.csv" -NoTypeInformation

Write-Host "$($InactiveUsers.Count) inactive users. Info saved to C:\Scripts\inactive-users.csv"
