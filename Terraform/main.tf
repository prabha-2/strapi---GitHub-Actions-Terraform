resource "aws_security_group" "strapi_sg" {
  name = "strapi-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
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

resource "aws_instance" "strapi" {
  ami           = "ami-0f5ee92e2d63afc18" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [aws_security_group.strapi_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              usermod -aG docker ec2-user
              docker pull ${var.docker_username}/strapi:${var.image_tag}
              docker run -d -p 1337:1337 --name strapi ${var.docker_username}/strapi:${var.image_tag}
              EOF
}
