# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Creates an ecs cluster, task definition & service
# ---------------------------------------------------------------------------------------------------

# req:
# 08a-iam-roles        - aws_iam_role.my-iamrole-ecs-task-exec.arn
# 09c-template-file.tf - data.template_file.my-script.rendered
# 08a-iam-roles.tf     - aws_iam_role_policy_attachment.my-iampa-ecs-task-exec
# variables.tf         - var.my-desired-fargate-cpu
# variables.tf         - var.my-desired-fargate-memory


resource "aws_ecs_task_definition" "my-ecs-td" {
  family                             = "myapp-task"
  execution_role_arn                 = aws_iam_role.my-iamrole-ecs-task-exec.arn
  network_mode                       = "awsvpc"
  requires_compatibilities           = ["FARGATE"]
  cpu                                = var.my-desired-fargate-cpu
  memory                             = var.my-desired-fargate-memory
  container_definitions              = data.template_file.my-script.rendered
}
