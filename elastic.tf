resource "aws_security_group" "sgelastic" {
  vpc_id = "${var.vpc_id}"
  name = "elastic"
  description = "Elastic"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9200
    to_port = 9200
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9300
    to_port = 9300
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

resource "aws_instance" "elastic" {
  instance_type = "t2.micro"
  ami = "${var.aws_ami}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.sgelastic.name}"]
  user_data = "${file("elastic.sh")}"

  tags {
    Name = "elastic-instance"
  }
}