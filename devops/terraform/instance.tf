resource "aws_launch_template" "ec2-tpl" {
  name = "${var.PROJECT_NAME}-ec2-tpl"

  image_id = var.AMIS[var.REGION]

  instance_type = var.INSTANCE_TYPE

  key_name = aws_key_pair.ec2-key-pair.key_name

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