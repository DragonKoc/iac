resource "aws_instance" "ubuntu-itea" {
  ami           = "ami-0bd9c26722573e69b"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.itea-subnet-public-3.id

  vpc_security_group_ids = [aws_security_group.itea-all.id]

  key_name = "mac-koc"

  tags = {
    "Name" = "ubuntu-itea"
  }

}