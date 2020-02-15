# Cria uma Amazon Linux 2 numa t2.micro com Apache utilizando "user_data"
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_server" {
    name = "web-server"
    description = "Libera o acesso a porta 80"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp" 
        cidr_blocks = ["0.0.0.0/0"]    
    }
    tags = {
        Name = "web-server"
    }
  
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon.id
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
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
    Name = var.name
  }
}