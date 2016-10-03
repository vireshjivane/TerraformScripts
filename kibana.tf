resource "aws_security_group" "sgkibana" {
  vpc_id = "${var.vpc_id}"
  name = "kibana"
  description = "Kibana"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5601
    to_port = 5601
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

resource "aws_instance" "kibana" {
  instance_type = "t2.micro"
  ami = "${var.aws_ami}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.sgkibana.name}"]
//  depends_on = ["${aws_instance.elastic}"]
  //  user_data = "${file("elastic.sh")}"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install default-jre -y",
      "wait",
      "sudo apt-get install default-jdk",
      "wait",
      "wget https://download.elastic.co/kibana/kibana/kibana-4.5.0-linux-x64.tar.gz -P ~/pkg",
      "mkdir -p ~/kibana",
      "cd ~/kibana && tar -zxvf ~/pkg/kibana-4.5.0-linux-x64.tar.gz",
      "cd ~/kibana/kibana-4.5.0-linux-x64",
      "sed -i 's/localhost/${aws_instance.elastic.public_ip}/g' /config/kibana.yml",
      "wait",
      "./bin/kibana > /home/ubuntu/kibana.log"
    ]
  }

  tags {
    Name = "kibana-instance"
  }
}