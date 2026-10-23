# This will be an offboarding account for a single user for now
Import-Module ActiveDirectory

$User = Get-ADUser -Identity "Specific Sam Account" -Properties DistinguishedName # Distinguished Name shows all the groups
Write-Host "Offboarding: $($User.DistinguishedName)"

# Gets the groups/membership the user is part of, filtering Domain Users since that is the default
$groups = Get-ADPrincipleGroupMembership -Identity $User | Where-Object {$_.Name -ne 'Domain Users'}

# Iterates through each group the user is part of and removes them without having to confirm
foreach ($x in $groups){
 Remove-ADGroupMember -Identity $x -Members $User -Confirm:$false
 Write-Host "$($User.SamAccountName) removed from $($x.Name)"
}

Disable-ADAccount -Identity $User
Write-Host "Disabled $($User.SamAccountName)"

Move-ADObject -Identity $User.DistinguishedName -TargetPath "OU=Disabled Users,DC=exampledomain,DC=local"
Write-Host "Moved $($User.SamAccountName) to Disabled Users"
