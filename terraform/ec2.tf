resource "aws_instance" "ubuntu-itea" {
  ami           = "ami-0a49b025fffbbdac6"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.itea-subnet-public-3.id

  vpc_security_group_ids = [aws_security_group.itea-all.id]

  key_name = "mac_central"

  tags = {
    "Name" = "ubuntu-itea"
  }

}