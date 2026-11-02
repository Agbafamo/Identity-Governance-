# Project Requirements — Microsoft Entra ID Governance

## 1. Purpose

This document records the lab prerequisites, licensing considerations, administrative roles, PowerShell requirements and Microsoft Learn references for the project.

**Tenant domain:** `skt42.onmicrosoft.com`

## 2. Technical prerequisites

| Requirement | Purpose |
|---|---|
| Microsoft Entra tenant | Host the lab identities, groups and governance configuration |
| Verified tenant domain | Use `skt42.onmicrosoft.com` for sample user principal names |
| Microsoft Entra admin center access | Configure roles, PIM, Access Reviews and Entitlement Management |
| PowerShell 7 recommended | Run the bulk user creation script |
| Microsoft Graph PowerShell SDK | Create and inspect Microsoft Entra users |
| Test users and groups | Validate each governance workflow |
| GitHub account | Store documentation and scripts |

## 3. Licensing considerations

Licensing depends on the exact feature, user population, tenant offer and current Microsoft Product Terms. Validate the tenant's entitlements before implementation.

| Workload | Licensing consideration |
|---|---|
| Basic user creation | Available with Microsoft Entra ID Free; administrative permissions are still required |
| PIM for Microsoft Entra roles | Requires Microsoft Entra ID P2 or an eligible Entra ID Governance / Microsoft Entra Suite entitlement |
| Access Reviews | Feature availability depends on the review scenario and licence. Entra ID P2 and Entra ID Governance offer different capabilities; validate reviewer and reviewed-user licensing requirements |
| Entitlement Management | Requires an eligible Microsoft Entra ID Governance or Microsoft Entra Suite entitlement for the applicable users and scenarios |

Important points:

- Microsoft 365 E5 generally includes Microsoft Entra ID P2 capabilities, subject to the applicable subscription terms.
- Microsoft 365 E3 generally includes Microsoft Entra ID P1, not P2.
- Microsoft Entra ID Governance and Microsoft Entra Suite are separate licensing offers. Do not assume that an E5 licence automatically includes every Entra ID Governance add-on capability.
- Guest and external-user scenarios can have different licensing treatment.
- A trial may expose features for evaluation, but it does not remove the need to validate production licensing.

Use Microsoft's current licensing pages and your tenant's licence inventory to confirm eligibility before enabling features.

## 4. Administrative roles and permissions

Use the least-privileged role that supports the task. Exact permissions can vary by operation and tenant configuration.

| Workload | Typical administrative role |
|---|---|
| Create users | User Administrator |
| Configure PIM for Microsoft Entra roles | Privileged Role Administrator |
| Configure Access Reviews | Identity Governance Administrator, or another role explicitly authorised for the relevant review |
| Configure Entitlement Management | Identity Governance Administrator |

For Microsoft Graph PowerShell user creation, the delegated `User.ReadWrite.All` permission is requested by the sample script. The signed-in administrator must also have sufficient directory privileges and consent must be granted where required. Use a dedicated lab administrator account.

## 5. PowerShell and Microsoft Graph setup

The user-creation workload uses Microsoft Graph PowerShell rather than the Azure `Az` module. Microsoft Graph is the API used to manage Microsoft Entra directory users.

Install the SDK:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

Connect with the required delegated permission:

```powershell
Connect-MgGraph -Scopes "User.ReadWrite.All"
```

Check the signed-in context:

```powershell
Get-MgContext
```

Disconnect when finished:

```powershell
Disconnect-MgGraph
```

## 6. Microsoft Learn references

### Microsoft Entra ID Governance

- Overview: https://learn.microsoft.com/en-us/entra/id-governance/

### User creation and Microsoft Graph PowerShell

- Bulk create users in the Microsoft Entra admin center: https://learn.microsoft.com/en-us/entra/identity/users/users-bulk-add
- Install the Microsoft Graph PowerShell SDK: https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation
- Create a user with Microsoft Graph PowerShell: https://learn.microsoft.com/en-us/powershell/module/microsoft.graph.users/new-mguser

### Privileged Identity Management

- What is Microsoft Entra Privileged Identity Management?: https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure
- Configure Microsoft Entra role settings: https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings

### Access Reviews

- Access Reviews overview: https://learn.microsoft.com/en-us/entra/id-governance/access-reviews-overview
- Create an access review of groups and applications: https://learn.microsoft.com/en-us/entra/id-governance/create-access-review

### Entitlement Management

- Entitlement Management overview: https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview
- Create and manage an access package: https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-package-create

### Licensing

- Microsoft Entra ID Governance licensing fundamentals: https://learn.microsoft.com/en-us/entra/id-governance/licensing-fundamentals
- Microsoft Entra licensing: https://learn.microsoft.com/en-us/entra/fundamentals/licensing

## 7. Security considerations

- Use lab-only identities and resources.
- Do not store passwords or access tokens in source files.
- Do not commit real employee records or sensitive screenshots.
- Do not use a shared temporary password in production.
- Confirm the tenant domain and UPN uniqueness before running the script.
- Use MFA and time-bound activation for privileged roles.
- Ensure an approver and fallback approver are configured where approval is required.
- Review Access Review decisions before applying them automatically.
- Verify resource roles and expiration behaviour in Entitlement Management.
