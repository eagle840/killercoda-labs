blank# terraform

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



# updated
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # ADD THIS LINE
  s3_use_path_style           = true 

  endpoints {
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    kms            = "http://localhost:4566"
    iam            = "http://localhost:4566"
  }
}

# 2. Create a KMS Key for our "Vault"
resource "aws_kms_key" "vault_key" {
  description             = "KMS key for encrypting our local vault"
  deletion_window_in_days = 7
}

# 3. Create the S3 Bucket
resource "aws_s3_bucket" "lab_bucket" {
  bucket = "killercoda-lab-storage"
}

# 4. Create the "Vault" (Secrets Manager Secret)
resource "aws_secretsmanager_secret" "db_vault" {
  name       = "my-app-secret-vault"
  kms_key_id = aws_kms_key.vault_key.arn
}

# 5. Add a "Secret Value" to the vault
resource "aws_secretsmanager_secret_version" "db_vault_value" {
  secret_id     = aws_secretsmanager_secret.db_vault.id
  secret_string = jsonencode({
    username = "admin"
    password = "SuperSecretPassword123!"
  })
}

# Outputs for easy verification
output "bucket_name" {
  value = aws_s3_bucket.lab_bucket.id
}

output "secret_arn" {
  value = aws_secretsmanager_secret.db_vault.arn
}

```

