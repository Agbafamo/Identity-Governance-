<#
.SYNOPSIS
    Creates sample Microsoft Entra ID users from a CSV file.

.DESCRIPTION
    Reads employee records from sample-data/users.csv, checks whether each
    user principal name already exists, and creates users that do not exist.

    Run this script from the repository root directory.

.NOTES
    Lab demonstration only. The script prompts for one temporary password
    and applies it to each newly created sample account. Do not use a shared
    password in production.
#>

# Temporary password for newly created accounts
$PasswordProfile = @{
    Password = "Temp@2026Secure!"
    ForceChangePasswordNextSignIn = $true
}

# Import CSV
$Users = Import-Csv -Path "C:\Users\OluwafemiShorunke\Documents\users.csv"

# Store creation results
$Results = foreach ($User in $Users) {

    try {

        # Check whether user already exists
        $ExistingUser = Get-MgUser `
            -Filter "userPrincipalName eq '$($User.UserPrincipalName)'"

        if ($ExistingUser) {
            Write-Host "User already exists: $($User.UserPrincipalName)" -ForegroundColor Yellow
            continue
        }

        # Generate mail nickname from UPN
        $MailNickname = $User.UserPrincipalName.Split("@")[0]

        # Create user
        $NewUser = New-MgUser `
            -DisplayName $User.DisplayName `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -UserPrincipalName $User.UserPrincipalName `
            -MailNickname $MailNickname `
            -Department $User.Department `
            -JobTitle $User.JobTitle `
            -UsageLocation "NG" `
            -AccountEnabled `
            -PasswordProfile $PasswordProfile

        Write-Host "Successfully created: $($NewUser.DisplayName)" -ForegroundColor Green

        [PSCustomObject]@{
            DisplayName       = $NewUser.DisplayName
            UserPrincipalName = $NewUser.UserPrincipalName
            ObjectId          = $NewUser.Id
            Status            = "Created"
        }

    }
    catch {

        Write-Host "Failed: $($User.UserPrincipalName) - $($_.Exception.Message)" -ForegroundColor Red

        [PSCustomObject]@{
            DisplayName       = $User.DisplayName
            UserPrincipalName = $User.UserPrincipalName
            ObjectId          = ""
            Status            = "Failed"
        }
    }
}

# Export results
$Results | Export-Csv `
    -Path "$HOME\Documents\UserCreationResults.csv" `
    -NoTypeInformation

Write-Host "User provisioning process completed."

# Disconnect from Microsoft Graph.
Disconnect-MgGraph
