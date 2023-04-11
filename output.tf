output "dns_name" {
  description = "The dns name of alb"
  value       = aws_lb.ALB-tf.dns_name
}

output "rds_password" {
  description = "The database password"
  value       = random_password.password.result
  sensitive   = true
}
