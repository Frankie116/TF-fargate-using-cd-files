# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# outputs
# ---------------------------------------------------------------------------------------------------



# 05a-lb-alb.tf ----------------------------------------------------------
output my-website-address {
  description          = "Full website addresss including port number"
  value                = "${aws_route53_record.my-r53-record.fqdn}:${var.my-docker-port1}"
}

# 12a-ecs.tf -------------------------------------------------------------
output my-docker-port1 {
  description          = "Exposed docker port"
  value                = var.my-docker-port1
}

output my-docker-port2 {
  description          = "Exposed docker port"
  value                = var.my-docker-port2
}

output my-docker-port3 {
  description          = "Exposed docker port"
  value                = var.my-docker-port3
}

# 09c-template-file ----------------------------------------------------------
output my-ecs-cd-template1 {
  description          = "Name of the container definition"
  value                = var.my-ecs-cd-template1
}

output my-ecs-cd-template2 {
  description          = "Name of the container definition"
  value                = var.my-ecs-cd-template2
}

output my-ecs-cd-template3 {
  description          = "Name of the container definition"
  value                = var.my-ecs-cd-template3
}