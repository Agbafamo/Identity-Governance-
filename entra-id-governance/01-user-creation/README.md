# 01 — Bulk User Creation with Microsoft Graph PowerShell

## 1. Introduction

This workload demonstrates how FinTrust Financial Services can provision multiple employee identities in Microsoft Entra ID from a CSV file.

The organisation is onboarding employees across IT, Finance, Information Security and Human Resources. Creating each account manually is time-consuming and can result in inconsistent user attributes.

The proposed solution is a PowerShell script that reads employee information from a CSV file, checks whether each user principal name already exists, and creates the account if it does not.

**Tenant domain:** `skt42.onmicrosoft.com`

## 2. Business use case

FinTrust is onboarding a small group of employees. The IT administrator has received an approved employee list and needs to create their accounts with the correct display name, department and job title.

For this lab, the sample records use the tenant's `onmicrosoft.com` domain. Replace the sample identities if they already exist in your tenant.

## 3. Prerequisites

- Access to the lab Microsoft Entra tenant.
- A verified `skt42.onmicrosoft.com` tenant domain.
- A signed-in administrator with sufficient rights to create users.
- Microsoft Graph PowerShell SDK installed.
- The CSV file in `sample-data/users.csv`.

Install the SDK if it is not already installed:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

## 4. Sample employee data

The `sample-data/users.csv` file contains:

```csv
DisplayName,FirstName,LastName,UserPrincipalName,Department,JobTitle
James Adebayo,James,Adebayo,James.adebayo@skt42.onmicrosoft.com,IT,IT Administrator
Mary Johnson,Mary,Johnson,mary.johnson@skt42.onmicrosoft.com,Finance,Accountant
David Okafor,David,Okafor,david.okafor@skt42.onmicrosoft.com,Information Security,Security Analyst
Grace Williams,Grace,Williams,grace.williams@skt42.onmicrosoft.com,Human Resources,HR Officer
```

## 5. Implementation steps

### Step 1 — Open PowerShell

Open PowerShell 7 where possible. Navigate to the repository root:

```powershell
cd path\to\entra-id-governance
```

### Step 2 — Install Microsoft Graph PowerShell

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

### Step 3 — Connect to Microsoft Graph

The sample script requests the delegated `User.ReadWrite.All` permission:

```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

Sign in using the authorised lab administrator account and complete consent if required.

Verify the connection:

```powershell
Get-MgContext
```

### Step 4 — Review the CSV

Open `01-user-creation/sample-data/users.csv`. Confirm that each UPN ends in `@skt42.onmicrosoft.com` and that none of the sample users already exists.

### Step 5 — Run the script

From the repository root:

```powershell
.\01-user-creation\scripts\create-bulk-users.ps1
```

The script prompts for a temporary lab password, checks for existing UPNs, creates accounts and reports success or failure for each record.

### Step 6 — Verify the accounts

Use Microsoft Graph:

```powershell
Get-MgUser -Filter "userPrincipalName eq 'john.adebayo@skt42.onmicrosoft.com'" |
    Select-Object DisplayName, UserPrincipalName, Department, JobTitle, AccountEnabled
```

Repeat for the other sample users, or view all users:

```powershell
Get-MgUser -All |
    Where-Object { $_.UserPrincipalName -like "*@skt42.onmicrosoft.com" } |
    Select-Object DisplayName, UserPrincipalName, Department, JobTitle
```

You can also verify the accounts in the Microsoft Entra admin center under **Identity > Users > All users**.

## 6. Expected outcome

- Sample employee accounts are created in the tenant.
- Department and job title attributes are populated.
- Existing UPNs are skipped rather than duplicated.
- The script reports creation failures for investigation.
- Users are required to change the temporary password at next sign-in.

## 7. Security notes

The script prompts for one temporary password for this disposable lab run and applies it to the sample accounts. This is only to simplify the demonstration. Do not use a shared password in production. Production provisioning should generate unique temporary credentials, deliver them through an approved secure process, and follow the organisation's identity proofing and onboarding controls.

The password is not written to the CSV or repository. Do not commit credentials, tokens or exported password data to GitHub.

## 8. Evidence checklist

The evidence folder is intentionally empty. Add your own screenshots after completing the lab:

- [ ] Microsoft Graph PowerShell installation or module availability.
- [ ] Successful Graph connection and `Get-MgContext` (hide sensitive tenant details if necessary).
- [ ] Sample CSV records.
- [ ] Script execution showing created or skipped users (do not show passwords).
- [ ] User accounts visible in Microsoft Entra admin center.
- [ ] User properties showing department and job title.

Evidence location: `01-user-creation/evidence/`
