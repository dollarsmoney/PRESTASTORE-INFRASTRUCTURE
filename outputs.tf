output "ec2_public_ip" {
  description = "Public IP of PrestaShop EC2 instance"
  value       = aws_instance.prestashop_ec2.public_ip
}
