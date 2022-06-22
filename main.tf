module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

resource "aws_security_group" "game_snake_sg" {
  name        = "instances-snake-sg"
  description = "SG for Instances Snake Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Game Snake port 80"
    from_port   = 80
    to_port     = 80
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

  tags = var.sg_tags
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = var.instance_name
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.game_snake_sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("userdata.sh")

  tags = var.instance_tags
}
