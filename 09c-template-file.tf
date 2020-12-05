# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.3
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
  template                 = file("./templates/ecs/myapp.json.tpl")
  vars                     = {
    app_image              = var.my-docker-image
    app_port               = var.my-docker-port
    fargate_cpu            = var.my-desired-fargate-cpu
    fargate_memory         = var.my-desired-fargate-memory
    aws_region             = var.my-aws-region
  }
}