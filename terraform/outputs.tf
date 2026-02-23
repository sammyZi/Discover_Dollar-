output "instance_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.meanapp.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.meanapp.id
}
