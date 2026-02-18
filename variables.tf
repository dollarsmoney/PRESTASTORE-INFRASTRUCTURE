variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "ssh_allowed_cidr" {
  description = "Your public IP for SSH access"
  type        = string
}

variable "ec2_key_name" {
  description = "EC2 key pair name in AWS"
  type        = string
}
