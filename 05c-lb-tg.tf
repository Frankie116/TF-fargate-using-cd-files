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


resource "aws_lb_target_group" "my-lb-tg1" {
  name                  = "my-lb-tg1"
  vpc_id                = module.my-vpc.vpc_id
  protocol              = "HTTP"
  port                  = var.my-docker-port1
  target_type           = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = var.my-hc-interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-hc-path1
    unhealthy_threshold = "2"
  }
  tags                  = {
    Name                = "my-lb-tg1-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}

resource "aws_lb_target_group" "my-lb-tg2" {
  name                  = "my-lb-tg2"
  vpc_id                = module.my-vpc.vpc_id
  protocol              = "HTTP"
  port                  = var.my-docker-port2
  target_type           = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = var.my-hc-interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-hc-path2
    unhealthy_threshold = "2"
  }
  tags                  = {
    Name                = "my-lb-tg2-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}

resource "aws_lb_target_group" "my-lb-tg3" {
  name                  = "my-lb-tg3"
  vpc_id                = module.my-vpc.vpc_id
  protocol              = "HTTP"
  port                  = var.my-docker-port3
  target_type           = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = var.my-hc-interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-hc-path3
    unhealthy_threshold = "2"
  }
  tags                  = {
    Name                = "my-lb-tg3-${random_string.my-random-string.result}"
    Terraform           = "true"
    Project             = var.my-project-name
    Environment         = var.my-environment
  }
}

