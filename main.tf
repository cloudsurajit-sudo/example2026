data "aws_ami" "amazon_linux" { 
    most_recent = true 
    owners = ["amazon"] 
filter { 
    name = "name" 
    values = ["amzn2-ami-hvm--x86_64-gp2"] 
        } 
    } 
resource "aws_instance" "web" { 
    count = var.instance_count 
    ami = data.aws_ami.amazon_linux.id 
    instance_type = var.instance_type 
    subnet_id = var.subnet_ids[count.index % length(var.subnet_ids)] 
    tags = { 
        Name = "web-${var.environment}-${count.index}", 
        Environment = var.environment 
        } 
    } 
output "web_ips" { 
    value = aws_instance.web.public_ip 
    }