
# ---------------------------------------------------------------------------------------------------
# version  1.3
# Library: https://github.com/Frankie116/my-library.git
# provider details
# ---------------------------------------------------------------------------------------------------

provider "aws" {
  shared_credentials_file = "$HOME/.aws/credentials"
  profile                 = "default"
  region                  = var.my-aws-region
}