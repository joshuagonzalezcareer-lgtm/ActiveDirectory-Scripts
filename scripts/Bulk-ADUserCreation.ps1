# Best practice: Import Active Directory module to use the toolkit
Import-Module activedirectory

$Users = Import-Csv "C:\Scripts\users.csv" # Fetch matrix table

# For loop 
foreach ($Users in $Users) {

 $login_name = $User.SamAccountName

 # skip if the sam account name is already in the Active Directory
 if (Get-ADUser -F {SamAccountName -eq $login_name}) {
  Write-Warning "$login_name already exists. Skipping."
  continue
 }

 New-ADUser `
   -Name "$($User.FirstName) $($User.LastName)" `
   -SamAccountName $login_name`
   -Department $User.Department`
   -Title $User.Title`
   # This would be if it had a password:
   # -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $False
   # -ChangePasswordAtLogon $true
   # -Enabled $true

 Write-Host "Created $login_name"

}

