
# outputs.tf

output "alb_hostname" {
  value = aws_alb.my-alb.dns_name
}