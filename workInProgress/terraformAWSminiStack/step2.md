To install the **AWS CLI v2** in your Killercoda environment, you can run the following block of commands. Since Killercoda usually starts you as a user with `sudo` privileges, this will work perfectly.

### 1. Installation Commands
Copy and paste this into your Killercoda terminal:

```bash
# 1. Download the latest AWS CLI v2 installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# 2. Unzip the package (Killercoda usually has unzip pre-installed)
unzip awscliv2.zip

# 3. Run the installer
sudo ./aws/install

# 4. Clean up the installer files
rm -rf awscliv2.zip ./aws

# 5. Verify the installation
aws --version
```

`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"`{{exec}}

`unzip awscliv2.zip`{{exec}}

`sudo ./aws/install`{{exec}}

`rm -rf awscliv2.zip ./aws`{{exec}}

`aws --version`{{exec}}

### 2. Configure for MiniStack
Once installed, the CLI defaults to looking for real AWS servers. You need to "trick" it into looking at your local MiniStack container. You have two ways to do this:

**Option A: The "Dummy" Configuration (Recommended for Labs)**
Run `aws configure` and enter these values:
* **AWS Access Key ID**: `test`
* **AWS Secret Access Key**: `test`
* **Default region name**: `us-east-1`
* **Default output format**: `json`

**Option B: The "One-Liner" Export**
If you don't want to go through the interactive prompt, just run this:
```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
```{{copy}}

### 3. Testing the Connection
Now that you have both MiniStack (from your Docker Compose) and the CLI ready, try to create your first bucket:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://my-first-bucket
```{{exec}}

> **Pro-Tip for Killercoda:** Typing `--endpoint-url=http://localhost:4566` every time is annoying. You can create an alias in your `.bashrc` so you only have to type `awslocal`:
> 
> ```bash
> alias awslocal='aws --endpoint-url=http://localhost:4566'
> ```{{exec}}
> Now you can just run: `awslocal s3 ls`{{exec}}