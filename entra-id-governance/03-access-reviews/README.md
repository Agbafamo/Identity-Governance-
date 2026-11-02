# 03 — Microsoft Entra Access Reviews

## 1. Introduction

Microsoft Entra Access Reviews help organisations periodically confirm whether users still need access to groups, applications and other supported resources.

This workload demonstrates a manager-led review of a departmental security group at FinTrust Financial Services.

## 2. Business use case

FinTrust has a Finance security group used to grant access to Finance resources. Employees may move between departments or change responsibilities, but their previous group memberships are not always removed.

The organisation wants a Finance manager or designated group owner to review membership periodically and confirm whether each person still requires access.

For the lab, the group will deliberately contain two sample members who should not retain Finance access.

## 3. Proposed test scenario

Create the security group:

`FINTRUST-FINANCE-USERS`

| User | Department in sample data | Review decision | Reason |
|---|---|---|---|
| Mary Johnson | Finance | Approve | Finance employee |
| John Adebayo | IT | Deny | Not a member of Finance |
| Grace Williams | Human Resources | Deny | Not a member of Finance |

These are demonstration decisions. In a real review, the reviewer must use verified business information rather than relying only on a department attribute.

## 4. Prerequisites

- An eligible licence for the chosen Access Reviews scenario.
- An authorised administrator to create the review.
- A security group with test members.
- A designated reviewer, such as the Finance manager or group owner.
- A test tenant in which review decisions can safely be applied.

## 5. Implementation steps

### Step 1 — Create the Finance security group

1. Open the Microsoft Entra admin center.
2. Navigate to **Identity > Groups > All groups**.
3. Select **New group**.
4. Set the group type to **Security**.
5. Enter `FINTRUST-FINANCE-USERS`.
6. Add Mary Johnson, John Adebayo and Grace Williams as members.
7. Assign an appropriate group owner, such as the test Finance manager.
8. Create the group.

### Step 2 — Open Access Reviews

1. Navigate to **ID Governance > Access Reviews**.
2. Select **New access review**.
3. Choose the review type for **Groups and Teams**.

### Step 3 — Configure the review

Use the following as the proposed lab configuration. The exact options displayed depend on the review type and tenant licensing.

| Setting | Proposed value |
|---|---|
| Review name | Finance Department Access Review |
| Scope | Selected group |
| Group | FINTRUST-FINANCE-USERS |
| Reviewers | Group owner or Finance manager |
| Review duration | 7 days |
| Recurrence | Monthly, if supported and appropriate |
| Auto-apply results | Off initially; enable only after validating the process |

Choose whether to review all users or a specific subset according to the scenario. For this demonstration, review all group members.

### Step 4 — Start and complete the review

1. Create or start the review.
2. Sign in as the designated reviewer.
3. Open the review from the reviewer experience.
4. Examine each member and their business need.
5. Approve Mary Johnson.
6. Deny John Adebayo and Grace Williams.
7. Provide meaningful justifications where the review experience supports them.
8. Submit the decisions.

### Step 5 — Apply the results

1. Return to the administrator's Access Reviews page.
2. Open the completed review.
3. Inspect the decisions and any users without a response.
4. Apply the results when they have been validated.
5. Check the group's membership and confirm the intended changes.

Do not assume that a denied decision has already changed group membership. Verify the review's application status and the actual group membership after applying results. Configure non-responder behaviour deliberately; it should not be assumed to mean automatic denial.

## 6. Expected outcome

- The Finance group has a documented review.
- The designated reviewer makes access decisions.
- Unnecessary memberships are removed after results are applied.
- Review completion and outcomes can be audited.
- The organisation can repeat the review on a defined schedule.

## 7. Evidence checklist

Add screenshots to `03-access-reviews/evidence/`:

- [ ] Finance security group and its initial membership.
- [ ] Access Review configuration.
- [ ] Selected reviewer.
- [ ] Review in progress or reviewer decision page.
- [ ] Approve/deny decisions.
- [ ] Completed review results.
- [ ] Result application status.
- [ ] Group membership after applying results.

## 8. Security considerations

- Select reviewers who understand the business need for access.
- Provide reviewers with enough context to make informed decisions.
- Review non-responder settings carefully.
- Validate results before applying them automatically.
- Keep evidence of the review and its outcome.
