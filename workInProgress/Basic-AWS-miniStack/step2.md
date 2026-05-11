
# IAM, Polices  And Tagging

# IAM

Using **MiniStack** to explore **Identity and Access Management (IAM)** is a brilliant move for local development. Since MiniStack is a lightweight alternative to LocalStack, it allows you to simulate AWS IAM without the fear of accidentally locking yourself out of a real account or racking up costs.

In MiniStack, IAM serves the same purpose as it does in AWS: defining **who** (Users/Roles) can do **what** (Policies) on **which** resources.

---

## 1. The Core IAM Workflow in MiniStack
Even though MiniStack is local, it validates the structure of your IAM entities. You generally follow this flow:
1. **Create a User/Role:** The identity that will perform actions.
2. **Define a Policy:** A JSON document specifying allowed/denied actions.
3. **Attach the Policy:** Binding the permission to the identity.



---

## 2. Practical Hands-on with MiniStack
Assuming you have MiniStack running (typically on `http://localhost:4566`), you can use the AWS CLI to practice.

### A. Create a "Developer" User
First, let's create a virtual user within your local environment.

`aws --endpoint-url=http://localhost:4566 iam create-user --user-name DevUser`{{exec}}

### B. Create and Attach a Policy
Let's say you want this user to only have Read-Only access to S3. You would create a `policy.json` file:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["s3:Get*", "s3:List*"],
            "Resource": "*"
        }
    ]
}
```{{copy}}

Then, apply it in MiniStack:

```bash
aws --endpoint-url=http://localhost:4566 iam create-policy \
    --policy-name S3ReadOnly \
    --policy-document file://policy.json
```{{exec}}

```bash
# Attach it to the user
aws --endpoint-url=http://localhost:4566 iam attach-user-policy \
    --user-name DevUser \
    --policy-arn arn:aws:iam::000000000000:policy/S3ReadOnly
```{{exec}}

---

## 3. Why Use IAM in MiniStack?
You might wonder, *"If it's just local, why bother with permissions?"* * **Testing Code Logic:** If your application code uses `boto3` or the AWS SDK, you can test how it handles `AccessDenied` errors by intentionally giving your local "mock" user restricted permissions.
* **Terraform Validation:** You can run `terraform apply` against MiniStack to ensure your IAM modules are syntactically correct and the ARNs (Amazon Resource Names) are being generated as expected.
* **Role Assumption:** You can practice **AssumeRole** logic, which is crucial for cross-account access or giving temporary permissions to Lambda functions.

### Quick Tip: The "Magic" Account ID
By default, MiniStack (like LocalStack) often uses `000000000000` as the default Account ID. When you see ARNs like `arn:aws:iam::000000000000:user/DevUser`, that's your local "mock" account!

Are you planning to use MiniStack primarily for manual CLI testing, or are you trying to integrate it into a CI/CD pipeline with something like Terraform?


## ORG's Roots, OU, and accounts


# Tagging


Because tagging is metadata, it’s treated as business logic rather than a protocol. However, there are industry de facto standards—specifically the **FinOps Foundation** and **ISO/IEC 27017**—that provide the closest thing to a "spec" for cloud resource management.


## 1. Industry Standard Tagging Categories

Since there's no IETF RFC, most AWS shops follow the **FinOps/Governance Framework**. You should implement these four "dimensions" to regain the control you had in Azure:

### Technical Tags (The "What")

* **Name:** The specific instance name (e.g., `web-server-01`).
* **Application/Workload:** The Azure equivalent of your "App Service Name".
* **Environment:** `prod`, `staging`, `dev`.

### Business Tags (The "Who")

* **Owner:** Who is responsible (email or team name).
* **CostCenter:** This is critical for AWS Cost Explorer.
* **Project:** Which budget does this pull from?

### Security Tags (The "Safety")

* **DataConfidentiality:** `public`, `internal`, `confidential`.
* **Compliance:** `pci`, `hipaa`, `none`.

### Automation Tags (The "How")

* **Schedule:** `office-hours` (used by scripts to shut down dev boxes at night).
* **Backup:** `daily`, `weekly`.

---

## 2. How to "Enforce" the Standard

In AWS, you use **Service Control Policies (SCPs)** via AWS Organizations or **Tag Policies**.

1. **Tag Policies:** These don't block creation but will flag resources in a compliance report if the tag keys don't match your case-sensitive schema (e.g., it will flag `Environment` if you mandated `environment`).
2. **SCP Enforcement:** This is the "Nuclear Option." You can write a policy that explicitly denies the `ec2:RunInstances` action if the request doesn't include specific tags.

---

The FinOps Foundation is the primary industry body that defines these standards. They don't provide a single "RFC-style" document, but rather a **Capability Framework**.

The specific URL you need for their tagging and allocation standards is:
**[https://www.finops.org/framework/capabilities/allocation/](https://www.finops.org/framework/capabilities/allocation/)**

### Key Takeaways from the FinOps Framework for an Azure Engineer:

Because you are used to the "Resource Group" being the source of truth, you should focus on the **"Cost Allocation"** capability within that link. Here is how the FinOps Foundation suggests you structure your metadata to mimic the "Control" you had in Azure:

#### 1. The "Required" Minimum Viable Tags (MVT)

The framework suggests that for any resource to be "manageable," it must have these 4 tags at a minimum. This replaces the Azure Resource Group metadata:

* **`CostCenter`**: Who pays for it.
* **`Application`** (or `AppID`): What logical system this belongs to.
* **`Environment`**: The lifecycle stage (Prod, Dev, etc.).
* **`Owner`**: The person/team responsible for the resource.

#### 2. Tagging Hygiene Standards

The FinOps Foundation highlights a "Standardization" problem that often bites Azure converts. In Azure, the platform forces some consistency; in AWS, it doesn't. They recommend:

* **Case Sensitivity:** AWS tags are case-sensitive. If one person uses `Environment` and another uses `environment`, they are different. **Standardize on PascalCase or lowercase immediately.**
* **Forbidden Characters:** Avoid spaces. Use hyphens or underscores.
* **Automation First:** The standard is to tag via **Infrastructure as Code (IaC)**. If it’s not tagged in Terraform/Bicep/CloudFormation, it shouldn't exist.

#### 3. How to view your "Resource Groups" in AWS

Once you apply these FinOps tags, you can use the **AWS Tag Editor** and **Resource Groups** service to create "Virtual Resource Groups."

* **URL:** [https://console.aws.amazon.com/resource-groups/home](https://console.aws.amazon.com/resource-groups/home)
* **Function:** You create a "Group" by defining a query (e.g., "Show me everything where `Tag:Project` = `Phoenix`"). This will give you a list that looks and feels exactly like an Azure Resource Group.

### Other "Non-IETF" but Official Standards:

If you want something more "technical" and less "financial," AWS publishes their own **Tagging Best Practices Whitepaper**:

* **URL:** [https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html)


---



## 1. The "Swiss Army Knife": `resourcegroupstaggingapi`

This is a global service that allows you to tag resources across different services (EC2, S3, RDS, etc.) using a single unified syntax. This is the closest thing to "management at scale."

### Bulk Tagging Resources

Use this to apply your FinOps tags (like `CostCenter`) to a list of ARNs across multiple services at once.

```bash
aws resourcegroupstaggingapi tag-resources \
    --resource-arn-list arn:aws:ec2:us-east-1:1234:instance/i-0a1b2c \
                     arn:aws:s3:::my-bucket \
    --tags CostCenter=80432,Owner=PlatformTeam

```

### Finding "Untagged" Resources

To find resources that are missing your mandatory Azure-style "Resource Group" metadata:

```bash
# Finds resources that do NOT have the 'Environment' tag
aws resourcegroupstaggingapi get-resources \
    --tag-filters Key=Environment,Values= \
    --query 'ResourceTagMappingList[*].ResourceARN'

```

---

## 2. Recreating the "Resource Group" View

In Azure, you just click the group. In AWS, you create a **Tag-Based Resource Group** via the CLI. Once created, you can manage these resources as a single unit.

### Create a "Virtual" Resource Group

This command creates a group named "Production-Web-App" that automatically includes any resource with the `Env=Prod` tag.

```bash
aws resource-groups create-group \
    --name "Production-Web-App" \
    --resource-query '{
        "Type": "TAG_FILTERS_1_0",
        "Query": "{\"ResourceTypeFilters\":[\"AWS::AllSupported\"],\"TagFilters\":[{\"Key\":\"Env\",\"Values\":[\"Prod\"]}]}"
    }'

```

---

## 3. Service-Specific Commands (The "Legacy" Way)

Some older automation scripts still use service-specific commands. You’ll encounter these frequently in existing codebases.

### EC2 (Instances, Volumes, Snapshots)

EC2 uses `create-tags`. Note the plural—you can tag many resources at once.

```bash
aws ec2 create-tags \
    --resources i-0123456789abcdef0 vol-01234567 \
    --tags Key=Project,Value=Phoenix Key=Stack,Value=Frontend

```

### S3 Buckets

S3 handles tagging differently because it's a "bucket-level" configuration rather than a simple metadata attribute.

```bash
aws s3api put-bucket-tagging \
    --bucket my-data-lake \
    --tagging 'TagSet=[{Key=Classification,Value=Confidential}]'

```

---

## 4. Auditing and Discovery

If you want to see what tags are currently on a resource (the `Get-AzResource` equivalent):

### List tags for a specific ARN

```bash
aws resourcegroupstaggingapi get-resources \
    --resource-arn-list <RESOURCE_ARN>

```

### Get all unique tag keys in a region

Useful for finding "shadow" tags like `env`, `Environment`, and `ENVIRONMENT` so you can consolidate them.

```bash
aws resourcegroupstaggingapi get-tag-keys

```
# CREATE THE POLICY
---


To add an SCP, you use the `organizations` service within the AWS CLI. Note that you must run these commands from the **Management Account** (the root of the organization).

### Step 1: Create the Policy File

First, save the JSON policy to a file named `enforce-costcenter.json` on your local machine:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EnforceCostCenterTag",
      "Effect": "Deny",
      "Action": [
        "ec2:RunInstances",
        "s3:CreateBucket"
      ],
      "Resource": "*",
      "Condition": {
        "Null": {
          "aws:RequestTag/costcenter": "true"
        }
      }
    }
  ]
}

```

### Step 2: Create the SCP in the Organization

Use the `create-policy` command. This uploads the policy to your AWS Organization but doesn't "turn it on" for any accounts yet.

```bash
aws organizations create-policy \
    --content file://enforce-costcenter.json \
    --description "Enforces costcenter tag on creation" \
    --name "EnforceCostCenterTag" \
    --type SERVICE_CONTROL_POLICY

```

**Note the `PolicyId**` returned in the JSON output (e.g., `p-12345abcde`). You will need it for the next step.

### Step 3: Attach the Policy

Now you must attach that policy ID to a target. The target can be a specific **Account ID** or an **Organizational Unit (OU)** ID.

```bash
aws organizations attach-policy \
    --policy-id p-12345abcde \
    --target-id 111122223333

```

---

### Important Prerequisites

Before these commands will work, ensure the following:

* **Enable SCPs:** By default, SCPs are not enabled when you first create an Organization. You must enable the "Service Control Policy" type in the Organizations settings.


```bash
aws organizations enable-policy-type \
    --root-id r-examplerootid111 \
    --policy-type SERVICE_CONTROL_POLICY

```


* **Permissions:** Your CLI user must have `organizations:CreatePolicy` and `organizations:AttachPolicy` permissions.


* **Management Account:** These commands will fail if run from a member/child account.



### How to verify it's working

Try to create an S3 bucket without a tag. If the SCP is active, you should receive an `AccessDenied` error even if your IAM user has full S3 permissions:

```bash
# This should FAIL
aws s3 mb s3://my-test-bucket-12345

# This should SUCCEED
aws s3api create-bucket --bucket my-test-bucket-12345 --tagging 'TagSet=[{Key=costcenter,Value=finance}]'

```

```

```


