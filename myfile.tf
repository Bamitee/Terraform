provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZTMZSB2ZTNT3AOMA"
  secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Testing"
  }
}

resource "aws_subnet" "Testing" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Testing"
  }
}