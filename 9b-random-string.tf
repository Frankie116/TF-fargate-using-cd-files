# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.2
# Enables a random string to be used.
# ---------------------------------------------------------------------------------------------------

# req:
# none


resource "random_string" "my-random-string" {
  length                = 3
  min_lower             = 3
  special               = false
}