# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Creates an ecs cluster, task definition & service
# ---------------------------------------------------------------------------------------------------

# req:
# 08a-iam-roles        - aws_iam_role.my-iamrole-ecs-task-exec.arn
# 09c-template-file.tf - data.template_file.my-template-file.rendered
# 04b-sg.tf            - aws_security_group.my-ecs-sg.id
# 01a-vpc.tf           - module.my-vpc.private_subnets
# 05a-lb-alb.tf        - aws_lb_target_group.my-lb-tg.id
# 05b-lb-listeners     - aws_lb_listener.my-lb-listener-http
# 08a-iam-roles.tf     - aws_iam_role_policy_attachment.my-iampa-ecs-task-exec
# variables.tf         - var.my-desired-fargate-cpu
# variables.tf         - var.my-desired-fargate-memory
# variables.tf         - var.my-desired-container-count
# variables.tf         - var.my-docker-port


resource "aws_ecs_task_definition" "my-ecs-td" {
  family                             = "myapp-task"
  execution_role_arn                 = aws_iam_role.my-iamrole-ecs-task-exec.arn
  network_mode                       = "awsvpc"
  requires_compatibilities           = ["FARGATE"]
  cpu                                = var.my-desired-fargate-cpu
  memory                             = var.my-desired-fargate-memory
  container_definitions              = data.template_file.my-script.rendered
}
