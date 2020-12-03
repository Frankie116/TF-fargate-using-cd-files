# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.3
# create security groups
# ---------------------------------------------------------------------------------------------------

#req:
# 1a-vpc.tf           - module.my-vpc.vpc_id
# 1a-vpc.tf           - module.my-vpc.public_subnets_cidr_blocks
# 9b-random-string.tf - random_string.my-random-string.result
# variables.tf        - var.my-project-name
# variables.tf        - var.my-environment




module "my-lb-sg" {
  source                   = "terraform-aws-modules/security-group/aws//modules/web"
  version                  = "3.12.0"
  name                     = "my-lb-sg-${random_string.my-random-string.result}"
  description              = "Security group for load balancer with HTTP ports open within VPC"
  vpc_id                   = module.my-vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      description          = "my-docker-port"
      protocol             = "tcp"
      from_port            = var.my-docker-port
      to_port              = var.my-docker-port
      cidr_blocks          = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks  = [
    {
      description          = "my egress ports"
      protocol             = "-1"
      from_port            = 80
      to_port              = 80
      cidr_blocks          = "0.0.0.0/0"
    },
  ]
  tags                     = {
    Name                   = "my-lb-sg-${random_string.my-random-string.result}"
    Terraform              = "true"
    Project                = var.my-project-name
    Environment            = var.my-environment
  }
}



resource "aws_security_group_rule" "my-ingress-rule" {
  type                     = "ingress"
  from_port                = var.my-docker-port
  to_port                  = var.my-docker-port
  protocol                 = "tcp"
  security_group_id        = module.my-ecs-sg.this_security_group_id
  source_security_group_id = module.my-lb-sg.this_security_group_id
}

# module "my-ecs-sg" {
#   source                   = "terraform-aws-modules/security-group/aws//modules/web"
#   version                  = "3.12.0"
#   name                     = "my-ecs-sg-${random_string.my-random-string.result}"
#   description              = "allow inbound access from the ALB only"
#   vpc_id                   = module.my-vpc.vpc_id
  
#   # computed_ingress_with_source_security_group_id = [
#   #   {
#   #     description              = "my-docker-port"
#   #     rule                     = "http-8080-tcp"
#   #     source_security_group_id = module.my-lb-sg.this_security_group_id
#   #   }
#   # ]
#   # number_of_computed_ingress_with_source_security_group_id = 1
  
#   egress_with_cidr_blocks  = [
#     {
#       description          = "my egress ports"
#       protocol             = "-1"
#       from_port            = 0
#       to_port              = 0
#       cidr_blocks          = "0.0.0.0/0"
#     },
#   ]

#   tags                     = {
#     Name                   = "my-ecs-sg-${random_string.my-random-string.result}"
#     Terraform              = "true"
#     Project                = var.my-project-name
#     Environment            = var.my-environment
#   }
# }





#----------------------------------------------------------------------------------------------
# Template module definition below
#----------------------------------------------------------------------------------------------


# module "my-server-sg" {
#   source                 = "terraform-aws-modules/security-group/aws//modules/web"
#   version                = "3.12.0"
#   name                   = "my-srv-sg-${random_string.my-random-string.result}"
#   description            = "Security group for web-servers with HTTP ports open within VPC"
#   vpc_id                 = module.my-vpc.vpc_id
#   ingress_cidr_blocks    = module.my-vpc.public_subnets_cidr_blocks
#   tags                   = {
#     Name                 = "my-srv-sg-${random_string.my-random-string.result}"
#     Terraform            = "true"
#     Project              = var.my-project-name
#     Environment          = var.my-environment
#   }
# }


