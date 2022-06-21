terraform {
  backend "s3" {
    bucket = "tfstate-santospedroh"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}