# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "my-cw-log-group" {
  name               = "/ecs/myapp"
  retention_in_days  = 30

  tags               = {
    Name             = "my-cw-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "my-cw-log-stream" {
  name               = "my-log-stream"
  log_group_name     = aws_cloudwatch_log_group.my-cw-log-group.name
}