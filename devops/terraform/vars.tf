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

variable "ASG_DESIRED_CAPACITY" {
  type    = number
  default = 1
}

variable "ASG_MAX_CAPACITY" {
  type    = number
  default = 3
}

variable "ASG_MIN_CAPACITY" {
  type    = number
  default = 1
}

variable "ASG_CAPACITY_PROVIDER_NAME" {
  type    = string
  default = "ganga"
}


variable "EXECUTION_ROLE_ARN" {
  type = string
  default = "arn:aws:iam::590184069711:role/ecsTaskExecutionRole"
}


variable "ECS_TASK_CPU" {
  type    = number
  default = 4096
}

variable "ECS_TASK_OS_FAMILY" {
  type    = string
  default = "LINUX"
}

variable "ECS_TASK_CPU_ARCHITECTURE" {
  type    = string
  default = "X86_64"
}