# Generate a private RSA key
resource "tls_private_key" "my_ec2key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an EC2 key pair with the generated public key
resource "aws_key_pair" "my_ec2key" {
  key_name   = "my-ec2key" 
  public_key = tls_private_key.my_ec2key.public_key_openssh
}

# Output the private key in PEM format
output "private_key_pem" {
  value     = tls_private_key.my_ec2key.private_key_pem
  sensitive = true   # Sensitive to avoid printing the key in Terraform output
}

# Save the private key to a local file in .pem format
resource "local_file" "private_key" {
  filename = "${path.module}/my-ec2key.pem"
  content  = tls_private_key.my_ec2key.private_key_pem
  file_permission = "0400"  # Read-only by the owner
}
