
# alb.tf

resource "aws_alb" "my-alb" {
  name            = "myapp-load-balancer"
  subnets         = module.my-vpc.public_subnets
  security_groups = [aws_security_group.my-lb-sg.id]
}

resource "aws_alb_target_group" "my-tg" {
  name        = "myapp-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.my-vpc.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.my-health-check-path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "my-alb-listener" {
  load_balancer_arn = aws_alb.my-alb.id
  port              = var.my-docker-port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.my-tg.id
    type             = "forward"
  }
}