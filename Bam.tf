  provider "aws" {
  region = "us-east-1" 
  access_key = "AKIAZTMZSB2ZRIHVNCXZ"
  secret_key = "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"
 }
 
  resource "aws_instance" "ttext" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"

  tags = {
    Name = "text"
  }
}


resource "aws_vpc" "Text" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Text"
  }
}


resource "aws_subnet" "Text" {
  vpc_id     = "vpc-0ad65c2e6dd61a1cf"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Text"
  }
}


resource "aws_s3_bucket" "ttext-bucket" {
  bucket = "ttext-bucket"
}

resource "aws_s3_bucket_accelerate_configuration" "ttext-bucket" {
  bucket = aws_s3_bucket.ttext-bucket.bucket
  status = "Enabled"
}

resource "aws_vpc" "ttext" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ttext"
  }
}

resource "aws_subnet" "ttext" {
  vpc_id     = aws_vpc.ttext.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "ttext"
  }
}



