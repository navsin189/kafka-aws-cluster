resource "aws_instance" "broker" {
    ami  = var.ami_image_id
    instance_type = var.ami_instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.broker_security_group.id]
    associate_public_ip_address = true
    availability_zone = var.av_zone
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file(var.key_name_path) #please pass your key path
    host     =  aws_instance.broker.public_ip
  }
  provisioner "file" {
    source      = var.broker_config_file
    destination = "/home/ec2-user/server.properties"
  }
  
  provisioner "remote-exec" {
    inline = var.kickstart_command
  }

  provisioner "remote-exec" {
    inline = [
      "sed -i 's/broker.id=0/broker.id=${var.broker_id}/g' /home/ec2-user/server.properties",
      "sed -i 's/localhost:2181/${var.zookeeper_public_ip}:${var.zookeeper_external_port}/' /home/ec2-user/server.properties",
      "cp /home/ec2-user/server.properties /home/ec2-user/kafka_2.13-3.4.0/config/server.properties",
      "echo 'cd /home/ec2-user/kafka_2.13-3.4.0/ && sh bin/kafka-server-start.sh -daemon config/server.properties' > startup_command.sh",
      "chmod +x startup_command.sh",
      "./startup_command.sh",
      "echo SETUP_DONE"
    ]
  }
}

#defining a volume for ec2 instance
resource "aws_ebs_volume" "broker_disk" {
  availability_zone = var.av_zone
  size              = 10

  tags = {
    Name = "broker"
    component = "controller"
  }
}
# attaching ec2 instance with ebs volume
resource "aws_volume_attachment" "broker_disk_attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.broker_disk.id
  instance_id = aws_instance.broker.id
}

output "instance_public_ip" {
  description = "Public IP address of the broker EC2 instance"
  value       = aws_instance.broker.public_ip
}

resource "aws_security_group" "broker_security_group" {
  name        = "broker-sg"
  description = "Allow TLS inbound traffic"

 ingress {
    description = "http"
    from_port   = 8000
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "broker_security_group_id" {
  value = aws_security_group.broker_security_group.id
}