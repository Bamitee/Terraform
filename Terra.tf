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


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ttext.id
}



resource "aws_route" "rt" {
  route_table_id            = "rtb-4fbb3ac4"
  destination_cidr_block    = "0.0.0.0/0"
 }

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ttext.id
  route_table_id = aws_internet_gateway.gw.id
}

resource "aws_security_group" "allow_ttext" {
  name        = "allow_web"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ttext.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.ttext.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.ttext.ipv6_cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.ttext.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.ttext.ipv6_cidr_block]
  }

ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.ttext.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.ttext.ipv6_cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ttext"
  }
}


