module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "snake-vpc"
  cidr = "10.200.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.200.101.0/24", "10.200.102.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
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

  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["server-01", "server-02"]) # Duas instâncias ec2

  name                   = "snake-game-${each.key}"
  ami                    = "ami-0cff7528ff583bf9a"
  instance_type          = "m5.large" # Tipo das instâncias m5.large
  vpc_security_group_ids = [aws_security_group.game_snake_sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("userdata.sh")
  tags = {
    Name = "snake-game-ec2"
    Terraform = "true"
    Environment = "prod"
    Team = "gamer-development"
    Application = "snake-game"
    Language = "javascript"
  }
}