# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.3
# create an s3 bucket & bucket policy to enable lb logs to be stored.  (Delete on destroy)
# ---------------------------------------------------------------------------------------------------

# req:
# 9b-random-string.tf - random_string.my-random-string.result
# variables.tf        - var.my-project-name
# variables.tf        - var.my-environment

resource "aws_s3_bucket" "my-s3-log-bucket" {
  bucket                 = "my-s3-log-bucket-${random_string.my-random-string.result}"
  acl                    = "private"
  force_destroy          = true
  
  versioning {
    enabled              = true
  }

    tags                 = {
    Name                 = "my-s3-log-bucket-${random_string.my-random-string.result}"
    Terraform            = "true"
    Project              = var.my-project-name
    Environment          = var.my-environment
  }
}

resource "aws_s3_bucket_policy" "my-s3-log-bucket" {
  bucket                = aws_s3_bucket.my-s3-log-bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::my-s3-log-bucket-${random_string.my-random-string.result}/*",
      "Condition": {
      }
    }
  ]
}
POLICY
}