
output "instance_public_ip" {
  description = "Public IP instance"
  value = module.ec2_instance.public_ip
}