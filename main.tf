data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm--x86_64-gp2"]
  }
}
resource "aws_instance" "assignments_instance" {
  count         = var.instance_count
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.target.id
  tags = {
    Name = assignment-ec2-instance
  }
}
output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.assignments_instance.id
}