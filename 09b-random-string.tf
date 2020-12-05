# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.4
# Generates a random number which is stored in a variable.
# ---------------------------------------------------------------------------------------------------

# req:
# none


resource "random_string" "my-random-string" {
  length                = 3
  min_lower             = 3
  special               = false
}