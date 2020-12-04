
# outputs.tf

output "my-alb-hostname" {
  value = aws_lb.my-alb.dns_name
}