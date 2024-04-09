variable "REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0ae04266c242a534b"
  }
}


variable "PROJECT_NAME" {
  type    = string
  default = "aws-ecs-deployment"

}


# variable "INSTANCE_TYPE" {
#   type    = string
#   default = "t2.micro"

# }