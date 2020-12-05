
# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.3
# provider details
# ---------------------------------------------------------------------------------------------------

provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = var.my-aws-region
}