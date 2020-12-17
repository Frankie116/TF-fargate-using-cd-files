# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Creates auto-scaling policies 
# ---------------------------------------------------------------------------------------------------

# req:
# 12a-ecs.tf           - aws_ecs_cluster.my-ecs-cluster.name
# 12a-ecs.tf           - aws_ecs_service.my-ecs-service.name


resource "aws_appautoscaling_target" "my-as-target" {
  service_namespace               = "ecs"
  resource_id                     = "service/${aws_ecs_cluster.my-ecs-cluster.name}/${aws_ecs_service.my-ecs-service.name}"
  scalable_dimension              = "ecs:service:DesiredCount"
  min_capacity                    = var.my-desired-container-count
  max_capacity                    = 4
}


# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "my-as-policy-up" {
  name                            = "myapp-scale-up"
  service_namespace               = "ecs"
  resource_id                     = "service/${aws_ecs_cluster.my-ecs-cluster.name}/${aws_ecs_service.my-ecs-service.name}"
  scalable_dimension              = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type               = "ChangeInCapacity"
    cooldown                      = 60
    metric_aggregation_type       = "Average"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [aws_appautoscaling_target.my-as-target]
}


# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "my-as-policy-down" {
  name                            = "myapp-scale-down"
  service_namespace               = "ecs"
  resource_id                     = "service/${aws_ecs_cluster.my-ecs-cluster.name}/${aws_ecs_service.my-ecs-service.name}"
  scalable_dimension              = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type               = "ChangeInCapacity"
    cooldown                      = 60
    metric_aggregation_type       = "Average"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.my-as-target]
}


