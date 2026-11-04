# PIM Evidence – Implementation Note

## User Account Selection for Activation Testing

John Adebayo was initially intended for PIM activation testing. However, sign-in attempts with his account were unsuccessful, and the password reset option in Microsoft Entra ID returned an error. During the initial PowerShell user creation process, John's account was identified as an existing user and skipped, meaning the temporary password specified in the script was not applied to his account.

James Adebayo was subsequently created using PowerShell with a specified temporary password to facilitate the activation testing that could not be completed with John's account.

James was used to demonstrate the PIM activation workflow, including the activation request, justification, approval, active assignment, and audit history.
