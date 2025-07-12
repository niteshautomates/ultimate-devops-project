output "ec2_server_name" {
  value = aws_instance.bastion-server.tags.Name
}