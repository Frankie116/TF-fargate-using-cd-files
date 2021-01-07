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

resource "aws_ecs_service" "my-ecs-service1" {
  name                               = "my-ecs-service1"
  cluster                            = aws_ecs_cluster.my-ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.my-ecs-td1.arn
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
    container_name                   = var.my-application1
  }
  load_balancer { 
    target_group_arn                 = aws_lb_target_group.my-lb-tg1.id
    container_name                   = var.my-application1
    container_port                   = var.my-docker-port1
  }
  depends_on                         = [aws_lb.my-alb, aws_lb_listener.my-lb-listener-my-docker-port1, aws_iam_role_policy_attachment.my-iampa-ecs-task-exec]
}

resource "aws_ecs_service" "my-ecs-service2" {
  name                               = "my-ecs-service2"
  cluster                            = aws_ecs_cluster.my-ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.my-ecs-td2.arn
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
    container_name                   = var.my-application2
  }
  load_balancer { 
    target_group_arn                 = aws_lb_target_group.my-lb-tg2.id
    container_name                   = var.my-application2
    container_port                   = var.my-docker-port2
  }
  depends_on                         = [aws_lb.my-alb, aws_lb_listener.my-lb-listener-my-docker-port2, aws_iam_role_policy_attachment.my-iampa-ecs-task-exec]
}

resource "aws_ecs_service" "my-ecs-service3" {
  name                               = "my-ecs-service3"
  cluster                            = aws_ecs_cluster.my-ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.my-ecs-td3.arn
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
    container_name                   = var.my-application3
  }
  load_balancer { 
    target_group_arn                 = aws_lb_target_group.my-lb-tg3.id
    container_name                   = var.my-application3
    container_port                   = var.my-docker-port3
  }
  depends_on                         = [aws_lb.my-alb, aws_lb_listener.my-lb-listener-my-docker-port3, aws_iam_role_policy_attachment.my-iampa-ecs-task-exec]
}