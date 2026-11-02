# Microsoft Entra ID Governance Implementation

**Organisation:** FinTrust Financial Services (fictional)  
**Microsoft Entra tenant domain:** `skt42.onmicrosoft.com`  
**Project type:** Hands-on identity governance implementation

## 1. Project overview

This project demonstrates how an organisation can govern employee identities and access using Microsoft Entra ID. It uses a fictional financial services organisation, FinTrust Financial Services, as the business scenario.

The implementation covers four workstreams:

1. **User creation:** Create employee accounts in bulk using Microsoft Graph PowerShell.
2. **Privileged Identity Management (PIM):** Use eligible role assignments and just-in-time activation to reduce standing administrative privileges.
3. **Access Reviews:** Periodically validate membership of departmental groups and remove access that is no longer required.
4. **Entitlement Management:** Publish access packages so employees can request approved resources for a defined period.

The project is intended for a controlled lab tenant. Do not use real employee information or production credentials.

## 2. Business scenario

FinTrust Financial Services has approximately 500 employees across IT, Information Security, Finance, Human Resources, Risk and Compliance, and Customer Operations.

The organisation has identified several identity and access management weaknesses:

| Current challenge | Potential risk |
|---|---|
| User accounts are created manually | Errors, inconsistent attributes and slow onboarding |
| Administrators hold permanent privileged roles | Unnecessary standing privilege and greater impact if an account is compromised |
| Group membership is not reviewed regularly | Users may retain access after changing roles |
| Project access is handled through manual requests | Delays and inconsistent approval evidence |
| Temporary access is not consistently time-limited | Access may remain after the business need ends |

### Proposed solution

Implement Microsoft Entra ID Governance controls that support repeatable provisioning, just-in-time privileged access, periodic access certification and governed resource requests.

## 3. Lab tenant and naming convention

The tenant's default domain for this project is:

`skt42.onmicrosoft.com`

Example user principal names used in the sample data:

- `john.adebayo@skt42.onmicrosoft.com`
- `mary.johnson@skt42.onmicrosoft.com`
- `david.okafor@skt42.onmicrosoft.com`
- `grace.williams@skt42.onmicrosoft.com`

Before running the script, confirm that this domain is available and verified in the tenant. These are sample identities; check that the UPNs do not already exist.

## 4. Repository structure

```text
entra-id-governance/
├── README.md
├── REQUIREMENTS.md
├── 01-user-creation/
│   ├── README.md
│   ├── scripts/
│   │   └── create-bulk-users.ps1
│   ├── sample-data/
│   │   └── users.csv
│   └── evidence/
│       └── .gitkeep
├── 02-privileged-identity-management/
│   ├── README.md
│   └── evidence/
│       └── .gitkeep
├── 03-access-reviews/
│   ├── README.md
│   └── evidence/
│       └── .gitkeep
└── 04-entitlement-management/
    ├── README.md
    └── evidence/
        └── .gitkeep
```

Each workload folder contains its own introduction, business scenario, prerequisites, implementation steps, validation checks and evidence checklist. Evidence folders are intentionally empty except for `.gitkeep`, so Git tracks the folders until screenshots are added.

## 5. Project architecture and lifecycle

The four workstreams support different parts of identity governance:

1. Create employee identities and populate their attributes.
2. Grant standard access based on business responsibilities.
3. Use PIM when administrators need elevated Microsoft Entra roles.
4. Use entitlement management when employees need additional project resources.
5. Use access reviews to periodically validate group membership and access package assignments.

This is a conceptual relationship, not a mandatory linear sequence. Access Reviews can also review access package assignments, and PIM provides separate privileged-role review capabilities.

## 6. Workstream summary

### 01 — User creation

Create sample employee accounts from a CSV file with Microsoft Graph PowerShell. The script checks for an existing UPN before attempting creation.

### 02 — Privileged Identity Management

Assign selected administrators as eligible for appropriate Microsoft Entra roles. Configure activation controls such as MFA, justification, approval where appropriate, and a limited activation duration.

### 03 — Access Reviews

Create a review for a departmental security group. A designated manager or group owner reviews each member and confirms whether access is still required.

### 04 — Entitlement Management

Create a catalog and access package containing project resources. Configure an internal employee request policy, manager approval and time-limited assignments.

## 7. Security and operational principles

- Apply least privilege and use role-specific administrative accounts.
- Avoid assigning Global Administrator for routine tasks.
- Require MFA for privileged role activation.
- Use time-limited assignments where practical.
- Use test identities and non-production resources.
- Never commit passwords, tokens, certificates or real employee data to GitHub.
- Review the impact of automatic application of Access Review decisions before enabling it.
- Confirm that a resource is correctly configured before adding it to an access package.
- Record implementation evidence without exposing secrets or sensitive personal information.

## 8. Project boundaries

This project covers the four workstreams listed above. It does not implement a complete HR-driven joiner-mover-leaver process, Lifecycle Workflows, an HR system integration, or a production privileged access operating model.

User creation in this project is a provisioning exercise; it does not automatically assign every employee to all relevant groups or resources.

## 9. Expected outcomes

At completion, the repository should demonstrate:

- Bulk creation and verification of test identities.
- Eligible privileged role assignments and successful activation.
- A completed access review with decisions applied and membership verified.
- An access package with resources, approval and assignment expiration.
- Documentation and screenshots that explain what was configured and how it was validated.

## 10. Disclaimer

FinTrust Financial Services and all employee identities in this repository are fictional. This project is a lab demonstration and is not a substitute for a production security design, licensing review or change-management process.
