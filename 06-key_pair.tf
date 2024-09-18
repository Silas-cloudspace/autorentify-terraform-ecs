# Check if a key pair with the same name already exists
data "aws_key_pair" "existing_key" {
  key_name = "my-ec2key"
}

# Generate a private RSA key only if the key does not already exist
resource "tls_private_key" "my_ec2key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  # Only generate a key if one does not exist
  lifecycle {
    prevent_destroy = true  # Prevents the key from being destroyed by Terraform
    create_before_destroy = true  # Ensures new resources are created before destroying the old ones (if necessary)
  }

  depends_on = [data.aws_key_pair.existing_key]  # Ensure we check for an existing key first
}

# Create an EC2 key pair with the generated public key
resource "aws_key_pair" "my_ec2key" {
  key_name   = "my-ec2key"
  public_key = tls_private_key.my_ec2key.public_key_openssh

  # Do not attempt to create a new key pair if one already exists
  lifecycle {
    prevent_destroy = true  # Prevent accidental deletion of the key
    create_before_destroy = true
  }

  depends_on = [tls_private_key.my_ec2key]
}

# Output the private key in PEM format
output "private_key_pem" {
  value     = tls_private_key.my_ec2key.private_key_pem
  sensitive = true  # Sensitive to avoid printing the key in Terraform output
}

# Save the private key to a local file in .pem format
resource "local_file" "private_key" {
  filename = "${path.module}/my-ec2key.pem"
  content  = tls_private_key.my_ec2key.private_key_pem
  file_permission = "0400"  # Read-only by the owner
}
