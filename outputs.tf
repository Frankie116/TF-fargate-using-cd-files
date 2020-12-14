# ---------------------------------------------------------------------------------------------------
# version  1.3
# Library: https://github.com/Frankie116/my-library.git
# outputs
# ---------------------------------------------------------------------------------------------------


output "my-alb-hostname" {
  value = aws_lb.my-alb.dns_name
}

# 6a-route53.tf ----------------------------------------------------------
output this-new-dns-name {
  description          = "New Public DNS name of loadbalancer's route53 A record"
  value                = aws_route53_record.my-r53-record.fqdn
}


# 12a-ecs.tf -------------------------------------------------------------
output my-docker-port {
  description          = "Exposed docker port"
  value                = var.my-docker-port
}

# 09c-template-file ----------------------------------------------------------
output my-docker-image {
  description          = "Name of the docker image"
  value                = var.my-docker-image
}

