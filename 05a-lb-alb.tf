# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Creates an application load balancer
# ---------------------------------------------------------------------------------------------------

# req:
# 1a-vpc.tf             - module.my-vpc.public_subnets
# 4b-sg.tf              - [module.my-lb-sg.this_security_group_id]
# 7a-s3-bucket.tf       - aws_s3_bucket.my-s3-log-bucket.bucket
# 9b-random-string.tf   - random_string.my-random-string.result
# variables.tf          - var.my-project-name
# variables.tf          - var.my-environment


resource "aws_lb" "my-alb" {
  name                   = "my-alb"
  load_balancer_type     = "application"
  security_groups        = [aws_security_group.my-lb-sg.id]
  subnets                = module.my-vpc.public_subnets
  access_logs {
    bucket  = aws_s3_bucket.my-s3-log-bucket.bucket
    enabled = true
  }
  tags                   = {
    Name                 = "my-alb-${random_string.my-random-string.result}"
    Terraform            = "true"
    Project              = var.my-project-name
    Environment          = var.my-environment
  }
}











