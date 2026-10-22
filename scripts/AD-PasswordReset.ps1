Import-Module ActiveDirectory

$Users = Import-Csv "C:\Scripts\users.csv"
$NewPassword = ConvertTo-SecureString "Password123!" -AsPlainText -Force

# Iterate through each user in the .csv file
foreach ($User in $Users){
 Set-ADAccountPassword -Identity $User.SamAccountName -Reset - NewPassword $NewPassword -Force)
 Set-ADUser -Identity $User.SameAccountName -ChangePasswordAtLogon $true
 Write-Host "Reset password for $($User.SamAccountName)"
}
