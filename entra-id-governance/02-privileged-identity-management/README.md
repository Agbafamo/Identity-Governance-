# 02 — Privileged Identity Management (PIM)

## 1. Introduction

Microsoft Entra Privileged Identity Management (PIM) helps organisations manage, control and monitor access to important resources. For Microsoft Entra roles, PIM supports eligible assignments and time-limited activation so users do not need permanent administrative privileges for routine work.

## 2. Business use case

FinTrust Financial Services has IT and security administrators who perform privileged tasks. The organisation wants to reduce permanent administrative access and require administrators to activate a role only when they need it.

The lab will use these fictional identities:

| User | Job function | Proposed role | Assignment |
|---|---|---|---|
| John Adebayo | IT Administrator | User Administrator | Eligible |
| David Okafor | Security Analyst / Administrator | Security Administrator | Eligible |
| Grace Williams | IT Operations | Global Reader | Active, read-only lab role |

Only assign roles that match the user's lab responsibilities. Global Reader is a read-only role; it is not a substitute for a role that can make administrative changes.

## 3. Prerequisites

- Eligible Microsoft Entra ID P2 or applicable Entra ID Governance licensing for PIM.
- A tenant administrator authorised to configure PIM, typically Privileged Role Administrator.
- The test users created in workload 01.
- MFA methods registered for the users who will activate roles.
- A separate approver account if approval is enabled.

## 4. Implementation steps

### Step 1 — Open PIM

1. Sign in to the Microsoft Entra admin center.
2. Open **ID Governance > Privileged Identity Management**.
3. Select **Microsoft Entra roles**.

### Step 2 — Assign an eligible role

1. Open **Assignments**.
2. Select **Add assignments**.
3. Select the role **User Administrator**.
4. Select John Adebayo.
5. Set the assignment type to **Eligible**.
6. Choose an appropriate assignment duration, such as a time-bound lab eligibility period.
7. Review and assign.

Repeat for David Okafor with the **Security Administrator** role.

The role assignment is eligible; the user does not receive the active role until they activate it.

### Step 3 — Configure role activation settings

1. In PIM, open **Microsoft Entra roles > Settings**.
2. Select the relevant role.
3. Configure the activation controls supported by the tenant and selected role.

Suggested lab configuration:

| Control | Suggested value |
|---|---|
| Maximum activation duration | 1 hour |
| Require multifactor authentication | Enabled |
| Require justification | Enabled |
| Require ticket information | Optional; enable if the lab has a ticket reference process |
| Require approval | Enable for roles where a second-person approval is part of the scenario |
| Approvers | Designated senior IT administrator |

These are proposed lab values. Choose controls based on risk and operational needs. Approval is not mandatory for every role or organisation.

### Step 4 — Activate the role as the eligible user

1. Sign in as John Adebayo using a separate browser session or private window.
2. Open PIM.
3. Select **My roles > Microsoft Entra roles**.
4. Find the eligible User Administrator assignment.
5. Select **Activate**.
6. Complete MFA if prompted.
7. Enter the required justification and ticket details, if configured.
8. Submit the activation request.

If approval is configured, the designated approver must approve the request before the role becomes active.

### Step 5 — Verify activation

As an administrator, return to PIM and inspect the role assignment and audit/activation history. Confirm that the role became active and has an expiry time.

After the configured duration, confirm that the activation expires. You can also deactivate an active assignment where the portal provides that action.

## 5. Validation and expected outcome

- John and David appear as eligible for their respective roles.
- The users can activate eligible roles when needed.
- Configured MFA, justification and approval requirements are enforced.
- Active assignments have a defined end time.
- Activation events are available for audit.

## 6. Evidence checklist

Add screenshots to `02-privileged-identity-management/evidence/`:

- [ ] PIM landing page / Microsoft Entra roles.
- [ ] Eligible role assignment for John.
- [ ] Eligible role assignment for David.
- [ ] Role activation settings.
- [ ] Activation request and justification (hide personal information where appropriate).
- [ ] Approval record, if approval is configured.
- [ ] Active role with start and end time.
- [ ] PIM audit or activation history.

## 7. Security considerations

- Do not make every administrator a Global Administrator.
- Use role-specific permissions.
- Require MFA for privileged activation.
- Keep activation duration as short as operationally practical.
- Use approval for sensitive roles when it is appropriate.
- Maintain and test emergency access accounts separately; do not use them for routine administration.
