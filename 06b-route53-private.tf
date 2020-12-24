# ---------------------------------------------------------------------------------------------------
# version  1.5
# Library: https://github.com/Frankie116/my-library.git
# Purpose:    Create a new route53 record in an existing route53 hosted zone
# ---------------------------------------------------------------------------------------------------

# req:
# 3a-eip.tf:  [data.aws_eip.my-eip.public_ip]

# resource "aws_route53_zone" "my-zone" {
#   name = "my-zone-${random_string.my-random-string.result}.local"
#   vpc {
#     vpc_id = module.my-vpc.vpc_id
#   }
# }





