# 04 — Microsoft Entra Entitlement Management

## 1. Introduction

Microsoft Entra Entitlement Management enables organisations to govern access to resources through catalogs, access packages and request policies.

An access package can bundle resources such as groups, applications and SharePoint sites. A policy determines who can request the package, how approval works and how long the assignment lasts.

## 2. Business use case

FinTrust Financial Services is running a Financial Reporting Transformation Project. Employees from Finance, IT and Information Security need temporary access to project resources.

Rather than having an administrator manually add each person to groups and sites, FinTrust will publish an access package. Employees can request the package through the My Access portal, and an authorised manager can approve or reject the request.

## 3. Proposed access package

| Configuration | Proposed value |
|---|---|
| Catalog | FinTrust Project Resources |
| Access package | Financial Reporting Project Access |
| Group resource | FINTRUST-FINANCIAL-REPORTING |
| Group role | Member |
| SharePoint resource | Financial Reporting SharePoint site |
| Request audience | Internal employees in the directory |
| Approval | Required |
| Approver | Requester's manager, where manager data is populated |
| Assignment duration | 30 days |
| Extension | Subject to policy and approval |

The SharePoint site must exist and be available as a supported catalog resource before it can be added. If no SharePoint site is available in the lab, complete the first version using the security group only and document the limitation.

## 4. Prerequisites

- An eligible Microsoft Entra ID Governance or Microsoft Entra Suite entitlement for the scenario.
- An authorised Identity Governance Administrator or other appropriately delegated administrator.
- Test employee and manager accounts.
- The relevant security group and, optionally, a SharePoint site.
- Manager information populated for users if manager-based approval is selected.

## 5. Implementation steps

### Step 1 — Create the resource group

1. Open the Microsoft Entra admin center.
2. Navigate to **Identity > Groups > All groups**.
3. Create a new Security group named `FINTRUST-FINANCIAL-REPORTING`.
4. Add no members initially; access package assignment will provision membership.
5. Save the group.

### Step 2 — Create a catalog

1. Navigate to **ID Governance > Entitlement Management > Catalogs**.
2. Select **New catalog**.
3. Enter `FinTrust Project Resources`.
4. Add a description explaining that the catalog contains resources for approved project work.
5. Create the catalog.

### Step 3 — Add resources to the catalog

1. Open the new catalog.
2. Navigate to its resources.
3. Add the `FINTRUST-FINANCIAL-REPORTING` security group.
4. If a SharePoint site is available, add the site as another resource.
5. Save the resource configuration.

### Step 4 — Create an access package

1. Navigate to **Access Packages**.
2. Select **New access package**.
3. Enter the name `Financial Reporting Project Access`.
4. Add a description explaining the access provided.
5. Select the `FinTrust Project Resources` catalog.
6. Continue to the resource roles step.

### Step 5 — Select resource roles

1. Select the `FINTRUST-FINANCIAL-REPORTING` group.
2. Select the **Member** role.
3. If the SharePoint resource was added, select the appropriate site role that grants the required project access.
4. Review the selected resources and roles.

Grant only the permissions needed for the project. Do not select an owner role for ordinary project participants.

### Step 6 — Configure the request policy

Create an internal employee policy:

| Setting | Proposed value |
|---|---|
| Who can request access? | Users in the directory |
| Approval required | Yes |
| Approver | Requester's manager, if manager data is populated |
| Justification | Required |
| Assignment expiration | 30 days |
| Extension | Require review/approval according to the policy |

Configure a suitable fallback approver if the manager cannot be resolved. Confirm the policy's review and expiration options in the portal before publishing it.

### Step 7 — Publish and test the request

1. Finish the access package configuration.
2. Ensure the policy is available to the intended internal requestors.
3. Sign in as a test employee.
4. Open the My Access portal: https://myaccess.microsoft.com/
5. Find `Financial Reporting Project Access`.
6. Submit a request with a business justification.

### Step 8 — Approve or reject the request

1. Sign in as the designated approver.
2. Open the pending request from the approval experience.
3. Review the requestor and justification.
4. Approve or reject the request.
5. Verify the decision and assignment status.

### Step 9 — Verify provisioning and expiration

1. Return to Entitlement Management.
2. Open the access package and its assignments.
3. Confirm the employee has an active assignment.
4. Verify membership in `FINTRUST-FINANCIAL-REPORTING`.
5. If SharePoint is included, verify that the employee has the intended site access.
6. Check the assignment's expiration date.

## 6. Expected outcome

- Employees can request project resources through My Access.
- Requests are routed for approval.
- Approved assignments provision the selected resource roles.
- Assignments expire according to the configured policy.
- Administrators can inspect access package assignments and their status.

## 7. Evidence checklist

Add screenshots to `04-entitlement-management/evidence/`:

- [ ] Catalog creation.
- [ ] Resources added to the catalog.
- [ ] Access package details.
- [ ] Selected group and resource roles.
- [ ] Request policy and audience.
- [ ] Approval settings and approver.
- [ ] Employee request in My Access.
- [ ] Approval or rejection decision.
- [ ] Active access package assignment.
- [ ] Group membership or SharePoint access verification.
- [ ] Assignment expiration details.

## 8. Security considerations

- Keep the request audience as narrow as the business need requires.
- Use manager approval only when manager attributes are reliable.
- Configure a fallback approver.
- Grant Member rather than Owner unless ownership is genuinely required.
- Set an appropriate assignment duration.
- Verify that the selected resources grant only the intended access.
- Review and remove obsolete catalogs, packages and resource assignments.
