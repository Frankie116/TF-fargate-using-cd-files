# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Creates load balance listeners
# ---------------------------------------------------------------------------------------------------

# req:
# 05a-lb-alb.tf - aws_lb.my-alb.arn
# 05c-lb-tg.tf  - aws_lb_target_group.my-alb-target-group.arn
# variables.tf  - var.my-docker-port


resource "aws_lb_listener" "my-lb-listener-my-docker-port1" {
  load_balancer_arn       = aws_lb.my-alb.arn
  port                    = var.my-docker-port1
  protocol                = "HTTP"
  default_action {
    type                  = "forward"
    target_group_arn      = aws_lb_target_group.my-lb-tg1.arn
  }
}

resource "aws_lb_listener" "my-lb-listener-my-docker-port2" {
  load_balancer_arn       = aws_lb.my-alb.arn
  port                    = var.my-docker-port2
  protocol                = "HTTP"
  default_action {
    type                  = "forward"
    target_group_arn      = aws_lb_target_group.my-lb-tg2.arn
  }
}

resource "aws_lb_listener" "my-lb-listener-my-docker-port3" {
  load_balancer_arn       = aws_lb.my-alb.arn
  port                    = var.my-docker-port3
  protocol                = "HTTP"
  default_action {
    type                  = "forward"
    target_group_arn      = aws_lb_target_group.my-lb-tg3.arn
  }
}

