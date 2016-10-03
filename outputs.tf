output "mongo-instance-ip" {
  value = "${ aws_instance.mongo.public_ip}"
}

output "elastic-instance-ip" {
  value = "${ aws_instance.elastic.public_ip}"
}

output "kibana-instance-ip" {
  value = "${ aws_instance.kibana.public_ip}"
}