variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-051f8a213df8bc089"
  }
}


variable "PROJECT_NAME" {
  type    = string
  default = "aws-ecs-deployment"

}


variable "INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"

}


variable "KEY_PAIR_NAME" {
  type    = string
  default = "ecs-deployment"
}

variable "PUBLIC_KEY" {
  type    = string
  default = "mb.pub"
}