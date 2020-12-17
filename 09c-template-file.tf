# ---------------------------------------------------------------------------------------------------
# version  1.3
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
  template                   = file("./templates/ecs/my-container-def-script.json.tpl")
  vars                       = {
    s-image                  = var.my-docker-image
    s-port                   = var.my-docker-port
    s-fargate-cpu            = var.my-desired-fargate-cpu
    s-fargate-memory         = var.my-desired-fargate-memory
    s-aws-region             = var.my-aws-region
  }
}
