# Input variable definitions
variable "vpc_name" {
  description = "Snake of VPC"
  type        = string
  default     = "snake-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.200.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.200.1.0/24", "10.200.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.200.101.0/24", "10.200.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform = "true"
    Environment = "game"
  }
}

variable "sg_snake_name" {
  description = "Snake of SG HTTP"
  type        = string
  default     = "sg-snake-name"
}

variable "instance_type" {
    type = string
    default = "t1.micro"
}

variable "instance_name" {
    type = string
    default = "snake-game"
}

variable "instance_ami" {
    type = string
    default = "ami-0cff7528ff583bf9a"
}


