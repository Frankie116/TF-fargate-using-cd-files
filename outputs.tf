
# outputs.tf

output "my-alb-hostname" {
  value = aws_alb.my-alb.dns_name
}