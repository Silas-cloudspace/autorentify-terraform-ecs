# environment variables
variable "region" {
  description = "region to create resources"
  type = string
}

variable "project_name" {
  description = "project name"
  type = string
}

variable "environment" {
  description = "environment"
  type = string
}

# vpc variables
variable "vpc_cidr" {
  description = "vpc cidr block"
  type = string
}

variable "public_subnet_az1_cidr" {
  description = "public subnet az1 cidr block"
  type = string
}

variable "public_subnet_az2_cidr" {
  description = "public subnet az2 cidr block"
  type = string
}

variable "private_app_subnet_az1_cidr" {
  description = "private subnet az1 cidr block"
  type = string
}

variable "private_app_subnet_az2_cidr" {
  description = "private subnet az2 cidr block"
  type = string
}

variable "private_data_subnet_az1_cidr" {
  description = "private data subnet az1 cidr block"
  type = string
}

variable "private_data_subnet_az2_cidr" {
  description = "private data subnet az2 cidr block"
  type = string
}

# Security groups variable
variable "ssh_location" {
  description = "ip address that can ssh into the servers"
  type = string
}

# rds variables
variable "db_master_username" {
  description = "database username"
  type = string
}

variable "db_master_password" {
  description = "database password"
  type = string
}

# acm variables
variable "domain_name" {
  description = "domain name"
  type = string
}

variable "alternative_names" {
  description = "sub domain name"
  type = string
}

# S3 variables
variable "env_file_bucket_name" {
  description = "s3 bucket name"
  type = string
}

variable "env_file_name" {
  description = "env file name"
  type = string
}

# ECS variables
variable "architecture" {
  description = "ecs cpu architecture"
  type = string
}

variable "container_image" {
  description = "container image uri"
  type = string
}

# Route53 variables
variable "record_name" {
  description = "sub domain name"
  type = string
}