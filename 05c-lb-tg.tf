# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Creates target groups & attachments for load balancing
# ---------------------------------------------------------------------------------------------------

# req:
# 01a-vpc.tf            - module.my-vpc.vpc_id
# 02a-ec2-choose-ami.tf - aws_instance.my-server[count.index].id
# 09b-random-string.tf  - random_string.my-random-string.result
# main.tf               - local.instance-count (used by other modules)
# variables.tf          - var.my-docker-port
# variables.tf          - var.my-hc-interval
# variables.tf          - var.my-project-name
# variables.tf          - var.my-environment


resource "aws_lb_target_group" "my-lb-tg" {
  name                  = "my-lb-tg"
  vpc_id                = module.my-vpc.vpc_id
  protocol              = "HTTP"
  port                  = var.my-docker-port
  target_type           = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = var.my-hc-interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-hc-path
    unhealthy_threshold = "2"
  }
  tags                  = {
    Name                = "my-lb-tg-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}

resource "aws_lb_target_group" "my-lb-tg-27017" {
  name                  = "my-lb-tg-27017"
  vpc_id                = module.my-vpc.vpc_id
  protocol              = "HTTP"
  port                  = 27017
  target_type           = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = var.my-hc-interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-hc-path
    unhealthy_threshold = "2"
  }
  tags                  = {
    Name                = "my-lb-tg-27017-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}

resource "aws_lb_target_group" "my-lb-tg-8081" {
  name                  = "my-lb-tg-8081"
  vpc_id                = module.my-vpc.vpc_id
  protocol              = "HTTP"
  port                  = 8081
  target_type           = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = var.my-hc-interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-hc-path
    unhealthy_threshold = "2"
  }
  tags                  = {
    Name                = "my-lb-tg-8081-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}
# resource "aws_lb_target_group_attachment" "my-lb-attachment-27017" {
#   target_group_arn      = aws_lb_target_group.my-lb-tg-27017.arn
#   target_id             = "mongodb"
#   port                  = 27017
# }
