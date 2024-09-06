terraform {
  backend "s3" {
    bucket         = "autorentify-state-bucket"
    key            = "autorentify/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "autorentify-state-dynamo"
  }
}
