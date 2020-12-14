# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Creates cloudwatch logs
# ---------------------------------------------------------------------------------------------------

# req:
# None


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