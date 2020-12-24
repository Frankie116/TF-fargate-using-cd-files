# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Creates an ecs cluster, task definition & service
# ---------------------------------------------------------------------------------------------------

# req:
# 12b-ecs-td.tf        - aws_ecs_task_definition.my-ecs-td.arn
# 04b-sg.tf            - aws_security_group.my-ecs-sg.id
# 01a-vpc.tf           - module.my-vpc.private_subnets
# 05a-lb-alb.tf        - aws_lb_target_group.my-lb-tg.id
# 05b-lb-listeners     - aws_lb_listener.my-lb-listener-http
# 08a-iam-roles.tf     - aws_iam_role_policy_attachment.my-iampa-ecs-task-exec
# variables.tf         - var.my-desired-container-count
# variables.tf         - var.my-docker-port


resource "aws_ecs_cluster" "my-ecs-cluster" {
  name                               = "my-ecs-cluster"
}

resource "aws_ecs_service" "my-ecs-service" {
  name                               = "my-ecs-service"
  cluster                            = aws_ecs_cluster.my-ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.my-ecs-td.arn
  desired_count                      = var.my-desired-container-count
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = 420
  network_configuration {
    security_groups                  = [aws_security_group.my-ecs-sg.id]
    subnets                          = module.my-vpc.private_subnets
    assign_public_ip                 = true
  }
  service_registries {
    registry_arn                     = aws_service_discovery_service.my-sd-service-priv.arn
    # container_port                   = 3000 
    container_name                   = "my-app" 
  }
  load_balancer { 
    target_group_arn                 = aws_lb_target_group.my-lb-tg.id
    container_name                   = "my-app"
    container_port                   = var.my-docker-port
  }
  load_balancer { 
    target_group_arn                 = aws_lb_target_group.my-lb-tg-27017.id
    container_name                   = "mongodb"
    container_port                   = 27017
  }
    load_balancer { 
    target_group_arn                 = aws_lb_target_group.my-lb-tg-8081.id
    container_name                   = "mongo-express"
    container_port                   = 8081
  }
  depends_on                         = [aws_lb.my-alb, aws_lb_listener.my-lb-listener-my-docker-port, aws_lb_listener.my-lb-listener-8081, aws_iam_role_policy_attachment.my-iampa-ecs-task-exec]
}
