#=================================================
# S3 Backend TF Bucket 
#=================================================
resource "aws_s3_bucket" "backup_backend" {
  bucket = "terraform-backup-backend-0192731237"
}

resource "aws_s3_bucket_versioning" "backup_backend" {
  bucket = aws_s3_bucket.backup_backend.id

  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_public_access_block" "backup_backend" {
  bucket = aws_s3_bucket.backup_backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

#=================================================
# S3 Artifact Bucket 
#=================================================
resource "aws_s3_bucket" "artifact" {
  bucket = "terraform-artifact-0192731237"
}

resource "aws_s3_bucket_versioning" "artifact" {
  bucket = aws_s3_bucket.artifact.id

  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_public_access_block" "artifact" {
  bucket = aws_s3_bucket.artifact.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}