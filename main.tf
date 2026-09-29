data "aws_vpc" "selected" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_subnet" "target" {
  id = data.aws_subnets.all.ids[0] # Grabs the 1st subnet ID from the array
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}
resource "aws_instance" "assignments_instance" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.target.id
}
output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.assignments_instance.id
}
output "instance_private_ip" {
  description = "The private network IP address assigned to the EC2 instance"
  value       = aws_instance.assignments_instance.private_ip
}