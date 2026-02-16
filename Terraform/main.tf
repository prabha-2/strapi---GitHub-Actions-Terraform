resource "aws_security_group" "strapi_sg" {
  name = "strapi-security-group"

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "strapi_ec2" {
  ami           = "ami-03f4878755434977f" # Amazon Linux 2 in ap-south-1
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              usermod -a -G docker ec2-user

              docker pull ${var.docker_username}/strapi:${var.image_tag}
              docker run -d -p 1337:1337 --name strapi ${var.docker_username}/strapi:${var.image_tag}
              EOF

  tags = {
    Name = "Strapi-Server"
  }
}

