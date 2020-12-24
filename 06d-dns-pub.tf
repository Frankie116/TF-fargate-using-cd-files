# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Purpose:    Create a service discovery namespace for public zone
# ---------------------------------------------------------------------------------------------------


resource "aws_service_discovery_public_dns_namespace" "my-sd-namespace-pub" {
  name                = "intracom.uk"
  description         = "my-sd-namespace-pub"
}



resource "aws_service_discovery_service" "my-sd-service-pub" {
  name                = "my-sd-service-pub"
  dns_config {
    namespace_id      = aws_service_discovery_public_dns_namespace.my-sd-namespace-pub.id
    dns_records {
      ttl             = 10
      type            = "A"
    }
  }
  health_check_config {
    failure_threshold = 10
    resource_path     = "/"
    type              = "HTTP"
  }
}



