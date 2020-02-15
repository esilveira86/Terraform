# Cria uma Amazon Linux 2 numa t2.micro com Apache utilizando "user_data"

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t2.micro"
  key_name = "esilveira"
  user_data = <<EOT
        #!/bin/bash
        yum update -y
        yum install httpd -y
        service httpd start
        chkconfig httpd on
        cd /var/www/html
        echo "<html><h1>Meu Site</h1></html> " > index.html
    EOT

  tags = {
    Name = "web-server"
  }
}