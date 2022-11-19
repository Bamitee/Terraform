
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAZTMZSB2Z5UIWB7HT"
  secret_key = "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"
}

resource "aws_instance" "First-Server" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"

  tags = {
    Name = "Bam-server"
  }
}




