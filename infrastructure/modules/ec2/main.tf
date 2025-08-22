

resource "aws_instance" "bastion-server" {
  
  instance_type = var.instance_type
  ami = "ami-0861f4e788f5069dd" 
  vpc_security_group_ids = [var.vpc_security_group_id]
  #data.aws_ami.this.image_id
  subnet_id = var.subnet_id
  associate_public_ip_address = true
  key_name = var.key_name
  tags = {
    Name = var.name
  }
}