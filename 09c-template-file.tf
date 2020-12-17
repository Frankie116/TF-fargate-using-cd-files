# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Uses an existing script to boot an ec2 instance. 
# ---------------------------------------------------------------------------------------------------

# req:
# variables.tf - var.my-docker-image
# variables.tf - var.my-docker-port
# variables.tf - var.my-desired-fargate-cpu
# variables.tf - var.my-desired-fargate-memory
# variables.tf - var.my-aws-region

# A script named in the template variable needs to exist.
# Any variables named under vars (left) need to exist within the script file
# Any variables named under vars (right) need to exist in variables.tf


data "template_file" "my-script" {
  template                   = file("./templates/ecs/${var.my-ecs-cd-template}")
  vars                       = {
    my-cd-port               = var.my-docker-port
    my-cd-fargate-cpu        = var.my-desired-fargate-cpu
    my-cd-fargate-memory     = var.my-desired-fargate-memory
    my-cd-aws-region         = var.my-aws-region
  }
}