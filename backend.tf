terraform {
  backend "s3" {
    bucket         = "911570640739-mybucket"
    key            = "global/s3/terraform.tfstate" # Path inside the bucket
    region         = "us-east-1"                   # Your bucket's AWS region
    encrypt        = true                          # Server-side encryption
    use_lockfile   = false                       # Recommended for native S3 locking (v1.10+)
  }
}