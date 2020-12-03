# security.tf

# ALB Security Group: Edit to restrict access to the application
# resource "aws_security_group" "my-lb-sg" {
#   name              = "my-lb-sg"
#   description       = "controls access to the ALB"
#   vpc_id            = module.my-vpc.vpc_id

#   ingress {
#     protocol        = "tcp"
#     from_port       = var.my-docker-port
#     to_port         = var.my-docker-port
#     cidr_blocks     = ["0.0.0.0/0"]
#   }

#   egress {
#     protocol        = "-1"
#     from_port       = 0
#     to_port         = 0
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
# }

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "my-ecs-sg" {
  name              = "my-ecs-sg"
  description       = "allow inbound access from the ALB only"
  vpc_id            = module.my-vpc.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.my-docker-port
    to_port         = var.my-docker-port
    security_groups = [module.my-lb-sg.this_security_group_id]
  }

  egress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
  }
}