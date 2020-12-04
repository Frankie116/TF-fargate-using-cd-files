# ecs.tf

resource "aws_ecs_cluster" "my-cluster" {
  name                      = "myapp-cluster"
}

data "template_file" "my-template-file" {
  template = file("./templates/ecs/myapp.json.tpl")

  vars                     = {
    app_image              = var.my-docker-image
    app_port               = var.my-docker-port
    fargate_cpu            = var.my-desired-fargate-cpu
    fargate_memory         = var.my-desired-fargate-memory
    aws_region             = var.my-aws-region
  }
}

resource "aws_ecs_task_definition" "my-task-def" {
  family                   = "myapp-task"
  execution_role_arn       = aws_iam_role.my-iamrole-ecs-task-exec.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.my-desired-fargate-cpu
  memory                   = var.my-desired-fargate-memory
  container_definitions    = data.template_file.my-template-file.rendered
}

resource "aws_ecs_service" "my-service" {
  name                     = "my-service"
  cluster                  = aws_ecs_cluster.my-cluster.id
  task_definition          = aws_ecs_task_definition.my-task-def.arn
  desired_count            = var.my-desired-container-count
  launch_type              = "FARGATE"

  network_configuration {
    security_groups        = [aws_security_group.my-ecs-sg.id]
    subnets                = module.my-vpc.private_subnets
    assign_public_ip       = true
  }

  load_balancer { 
    target_group_arn       = aws_lb_target_group.my-lb-tg.id
    container_name         = "myapp"
    container_port         = var.my-docker-port
  }

  depends_on               = [aws_lb_listener.my-lb-listener-http, aws_iam_role_policy_attachment.my-iampa-ecs-task-exec]
}