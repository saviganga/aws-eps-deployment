# provision security groups
resource "aws_security_group" "elb_sg" {
  name        = "${var.PROJECT_NAME}-elb-sg"
  description = "Allow TLS inbound traffic from the internet"

  ingress {
    description = "Allow TLS inbound traffic from the internet"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Rule for HTTPS traffic (port 443)
  ingress {
    description = "Allow HTTPS inbound traffic from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-elb-sg"
  }
}
