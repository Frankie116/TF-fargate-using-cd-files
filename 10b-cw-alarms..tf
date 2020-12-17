# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Creates cloudwatch alarms used to trigger auto-scaling
# ---------------------------------------------------------------------------------------------------

# req:
# 11a-auto-scaling.tf  - [aws_appautoscaling_policy.my-as-policy-up.arn]
# 11a-auto-scaling.tf  - [aws_appautoscaling_policy.my-as-policy-down.arn]
# 12a-ecs.tf           - aws_ecs_cluster.my-ecs-cluster.name
# 12a-ecs.tf           - aws_ecs_service.my-ecs-service.name


# CloudWatch alarm that triggers the autoscaling up policy
resource "aws_cloudwatch_metric_alarm" "my-cw-service-cpu-high" {
  alarm_name                     = "myapp_cpu_utilization_high"
  comparison_operator            = "GreaterThanOrEqualToThreshold"
  evaluation_periods             = "2"
  metric_name                    = "CPUUtilization"
  namespace                      = "AWS/ECS"
  period                         = "60"
  statistic                      = "Average"
  threshold                      = "85"
  dimensions                     = {
    ClusterName                  = aws_ecs_cluster.my-ecs-cluster.name
    ServiceName                  = aws_ecs_service.my-ecs-service.name
  }
  alarm_actions                  = [aws_appautoscaling_policy.my-as-policy-up.arn]
}


# CloudWatch alarm that triggers the autoscaling down policy
resource "aws_cloudwatch_metric_alarm" "my-cw-service-cpu-low" {
  alarm_name                     = "myapp_cpu_utilization_low"
  comparison_operator            = "LessThanOrEqualToThreshold"
  evaluation_periods             = "2"
  metric_name                    = "CPUUtilization"
  namespace                      = "AWS/ECS"
  period                         = "60"
  statistic                      = "Average"
  threshold                      = "10"
  dimensions                     = {
    ClusterName                  = aws_ecs_cluster.my-ecs-cluster.name
    ServiceName                  = aws_ecs_service.my-ecs-service.name
  }
  alarm_actions                  = [aws_appautoscaling_policy.my-as-policy-down.arn]
}