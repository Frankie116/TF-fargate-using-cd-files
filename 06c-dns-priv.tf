# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Purpose:    Create a service discovery namespace for private zone
# ---------------------------------------------------------------------------------------------------


resource "aws_service_discovery_private_dns_namespace" "my-sd-namespace-priv" {
  name                  = "my-zone.local"
  description           = "my-sd-priv-dns"
  vpc                   = module.my-vpc.vpc_id
}



resource "aws_service_discovery_service" "my-sd-service-priv" {
  name                  = "my-sd-service"
  dns_config {
    namespace_id        = aws_service_discovery_private_dns_namespace.my-sd-namespace-priv.id
    dns_records {
      ttl               = 10
      type              = "A"
    }
    routing_policy      = "MULTIVALUE"
  }
  health_check_custom_config {
    failure_threshold   = 1
  }
}



