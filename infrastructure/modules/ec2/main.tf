data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["al2025-ami-2025*"]
  }
}

resource "aws_instance" "bastion-server" {
  instance_type = var.instance_type
  ami = data.aws_ami.this.image_id
  key_name = var.key_name
}