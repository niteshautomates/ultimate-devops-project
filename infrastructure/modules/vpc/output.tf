output "vpc_ipam_pool_regions" {
  value = aws_vpc_ipam.compute_vpc_ipam.operating_regions[*].region_name
}

output "subnet_id" {
  value = aws_subnet.compute_vpc_public_subnet.id
}

output "vpc_security_group_id" {
  value = aws_security_group.bastion_sg.id
}