# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Purpose:    Create a new route53 record in an existing route53 hosted zone
# ---------------------------------------------------------------------------------------------------

# req:
# 3a-eip.tf:  [data.aws_eip.my-eip.public_ip]

data "aws_route53_zone" "my-r53zone" {
  name                       = var.my-existing-r53-zone
}

resource "aws_route53_record" "my-r53-record" {
  zone_id                    = data.aws_route53_zone.my-r53zone.zone_id
  name                       = "${var.my-application}.${data.aws_route53_zone.my-r53zone.name}"
  type                       = "A"

  alias {
      zone_id                = var.my-lb-hosted-zone        
      name                   = aws_lb.my-alb.dns_name
      evaluate_target_health = false
    }
}








# ----------------------------------------------------------------------------------------------------
# use config below to point to an eip ----------------------------------------------------------------
# resource "aws_route53_record" "my-r53-record" {
#   zone_id                  = data.aws_route53_zone.my-r53zone.zone_id
#   name                     = "${var.my-application}.${data.aws_route53_zone.my-r53zone.name}"
#   type                     = "A"
#   ttl                      = "300"
#   records                  = [data.aws_eip.my-eip.public_ip]
# }



