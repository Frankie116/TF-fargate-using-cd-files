# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.3
# create security group rules
# ---------------------------------------------------------------------------------------------------

#req:
# 4b-sg.tf            - aws_security_group.my-lb-sg.id
# 4b-sg.tf            - aws_security_group.my-ecs-sg.id
# variables.tf        - var.my-docker-port

resource "aws_security_group_rule" "my-lb-ingress" {
  description              = "allow only docker port inbound from anywhere"
  security_group_id        = aws_security_group.my-lb-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.my-docker-port
  to_port                  = var.my-docker-port
  cidr_blocks              = ["0.0.0.0/0"]

  depends_on = [aws_security_group.my-lb-sg,aws_security_group.my-ecs-sg]
}

resource "aws_security_group_rule" "my-lb-egress" {
  description              = "allow any port to exit alb to anywhere"
  security_group_id        = aws_security_group.my-lb-sg.id
  type                     = "egress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  cidr_blocks              = ["0.0.0.0/0"]

  depends_on = [aws_security_group.my-lb-sg,aws_security_group.my-ecs-sg]
}

resource "aws_security_group_rule" "my-ecs-ingress" {
  description              = "allow only docker port inbound from alb only"
  security_group_id        = aws_security_group.my-ecs-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.my-docker-port
  to_port                  = var.my-docker-port
  source_security_group_id = aws_security_group.my-lb-sg.id

  depends_on = [aws_security_group.my-lb-sg,aws_security_group.my-ecs-sg]
}

resource "aws_security_group_rule" "my-ecs-egress" {
  description              = "allow any port to exit ecs to anywhere"
  security_group_id        = aws_security_group.my-ecs-sg.id
  type                     = "egress"
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  cidr_blocks              = ["0.0.0.0/0"]

  depends_on = [aws_security_group.my-lb-sg,aws_security_group.my-ecs-sg]
}