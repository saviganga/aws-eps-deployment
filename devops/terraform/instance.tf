
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "aws_launch_template" "ec2-tpl" {
  name = "${var.PROJECT_NAME}-ec2-tpl"

  image_id = data.aws_ami.amazon_linux_2.id
  
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  instance_type = var.INSTANCE_TYPE

  key_name = aws_key_pair.ec2-key-pair.key_name

  user_data = filebase64("${path.module}/scripts/configure-ecs-cluster.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = var.PROJECT_NAME
    }
  }

}
