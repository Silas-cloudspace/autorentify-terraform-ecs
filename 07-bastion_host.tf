# Data sources to reference existing VPC, subnets, and security groups
data "aws_vpc" "existing_vpc" {
  id = aws_vpc.vpc.id  # Reference to existing VPC
}

data "aws_subnet" "public_subnet_az1" {
  id = aws_subnet.public_subnet_az1.id  # Reference to existing public subnet AZ1
}

data "aws_security_group" "bastion_sg" {
  id = aws_security_group.bastion_security_group.id  # Reference to existing Bastion Security Group
}

# Create the EC2 Bastion Host
resource "aws_instance" "bastion" {
  ami                    = "ami-0b31d93fb777b6ae6"  # Replace with Amazon Linux 2023 AMI ID in eu-west-2
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_ec2key.key_name  # Reference the existing key pair
  availability_zone      = data.aws_availability_zones.availability_zones.names[0]  # Use AZ1
  subnet_id              = data.aws_subnet.public_subnet_az1.id  # Use Public Subnet AZ1
  vpc_security_group_ids = [data.aws_security_group.bastion_sg.id]  # Use Bastion SG by ID

  tags = {
    Name = "Bastion Host"
  }
}

