variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR Block"
  default     = "10.0.2.0/24"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
}

variable "allowed_ssh_ips" {
  description = "CIDR blocks allowed for SSH access"
  default     = ["0.0.0.0/0"]
}

variable "db_name" {
  description = "RDS Database name"
  default     = "mydatabase"
}

variable "db_username" {
  description = "RDS Database username"
  default     = "admin"
}

variable "db_password" {
  description = "RDS Database password"
  default     = "password"
}

