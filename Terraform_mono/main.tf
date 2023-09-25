provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "node" {
  ami                    = "ami-0989fb15ce71ba39e"
  instance_type          = "t3.micro"
  key_name               = "nazar-key-Stockholm"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("node.sh")

  tags = {
    Name    = "Node"
    Owner   = "Nazar Plaksa"
    Project = "Terraform"
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-0989fb15ce71ba39e"
  instance_type          = "t3.micro"
  key_name               = "nazar-key-Stockholm"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("web.sh.tpl", {
    node_public_ip = "${aws_instance.node.public_ip}"
  })

  tags = {
    Name    = "WEB"
    Owner   = "Nazar Plaksa"
    Project = "Terraform"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "22", "9007"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server SecurityGroup"
    Owner = "Nazar Plaksa"
  }
}

output "node_public_ip" {
  value = aws_instance.node.public_ip
}

output "web_public_ip" {
  value = aws_instance.web.public_ip
}
