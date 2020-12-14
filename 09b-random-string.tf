# ---------------------------------------------------------------------------------------------------
# version  1.4
# Library: https://github.com/Frankie116/my-library.git
# Generates a random number which is stored in a variable.
# ---------------------------------------------------------------------------------------------------

# req:
# none


resource "random_string" "my-random-string" {
  length                = 3
  min_lower             = 3
  special               = false
}