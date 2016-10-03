provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_access}"
}

resource "aws_security_group" "sgmongo" {
  vpc_id = "${var.vpc_id}"
  name = "mongo"
  description = "For MongoDB"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 27017
    to_port = 27017
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mongo" {
  instance_type = "t2.micro"
  ami = "${var.aws_ami}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.sgmongo.name}"]
  user_data = "${file("mongo.sh")}"
  tags {
    Name = "mongo-instance"
  }
}