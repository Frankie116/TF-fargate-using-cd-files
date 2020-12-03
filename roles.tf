# ECS task execution role data
data "aws_iam_policy_document" "my-iampd-ecs-task-exec" {
  version            = "2012-10-17"
  statement {
    sid              = ""
    effect           = "Allow"
    actions          = ["sts:AssumeRole"]

    principals {
      type           = "Service"
      identifiers    = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# ECS task execution role
resource "aws_iam_role" "my-iamrole-ecs-task-exec" {
  name               = var.my-ecs-task-execution-role-name
  assume_role_policy = data.aws_iam_policy_document.my-iampd-ecs-task-exec.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment" "my-iampa-ecs-task-exec" {
  role              = aws_iam_role.my-iamrole-ecs-task-exec.name
  policy_arn        = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}