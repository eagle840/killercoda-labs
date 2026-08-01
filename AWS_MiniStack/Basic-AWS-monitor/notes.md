The main AWS CLI command used for adding, updating, or managing tags on AWS resources is `aws resourcegroupstaggingapi tag-resources`.

Depending on the specific AWS service you are working with, many services also provide their own dedicated tagging commands.

---

### 1. The Universal Tagging Command

The **Resource Groups Tagging API** allows you to add tags to many different types of AWS resources simultaneously by providing their ARNs (Amazon Resource Names).

```bash
aws resourcegroupstaggingapi tag-resources \
    --resource-arn-list <RESOURCE_ARN> \
    --tags <KEY>=<VALUE>

```

**Example:**

```bash
aws resourcegroupstaggingapi tag-resources \
    --resource-arn-list arn:aws:ec2:us-east-1:123456789012:instance/i-1234567890abcdef0 \
    --tags Environment=Production,Owner=DevTeam

```

---

### 2. Service-Specific Tagging Commands

Many individual services have built-in `tag-resource` or `create-tags` commands. For example:

* **Amazon EC2:** Uses `create-tags`
```bash
aws ec2 create-tags --resources i-1234567890abcdef0 --tags Key=Name,Value=MyWebServer

```


* **Amazon S3:** Uses `put-bucket-tagging`
```bash
aws s3api put-bucket-tagging --bucket my-bucket --tagging 'TagSet=[{Key=Environment,Value=Test}]'

```


* **Amazon RDS:** Uses `add-tags-to-resource`
```bash
aws rds add-tags-to-resource --resource-name arn:aws:rds:us-east-1:123456789012:db:my-db --tags Key=Stage,Value=Beta

```