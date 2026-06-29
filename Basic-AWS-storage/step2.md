# S3 Object Storage

In this step, we will learn how to create and manage object storage in AWS using S3.

---

## 1. Create a Bucket
A bucket is the container for your objects.

```bash
awslocal s3 mb s3://my-lab-bucket
```{{exec}}

## 2. Upload Data
Once the bucket is created, you can upload files to it.

```bash
echo "Hello, S3!" > data.txt
awslocal s3 cp data.txt s3://my-lab-bucket/data.txt
```{{exec}}

## 3. List Bucket Contents
Verify that your object was uploaded successfully.

```bash
awslocal s3 ls s3://my-lab-bucket/
```{{exec}}
