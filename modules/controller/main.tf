resource "aws_instance" "zookeeper" {
    ami  = var.ami_image_id
    instance_type = var.ami_instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.zoopkeeper_security_group.id]
    associate_public_ip_address = true
    availability_zone = var.av_zone
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file(var.key_name_path) #please pass your key path
    host     =  aws_instance.zookeeper.public_ip
  }
  provisioner "file" {
    source      = var.zookeeper_config_file
    destination = "/home/ec2-user/zookeeper.properties"
  }
  provisioner "remote-exec" {
    inline = var.kickstart_command
  }

  provisioner "remote-exec" {
    inline = [
      "cp /home/ec2-user/zookeeper.properties /home/ec2-user/kafka_2.13-3.4.0/config/zookeeper.properties",
      "echo 'cd /home/ec2-user/kafka_2.13-3.4.0/ && sh bin/zookeeper-server-start.sh config/zookeeper.properties' > startup_command.sh",
      "chmod +x startup_command.sh",
      "nouhp ./startup_command.sh",
    ]
  }
}

#defining a volume for ec2 instance
resource "aws_ebs_volume" "zookeeper_disk" {
  availability_zone = var.av_zone
  size              = 10

  tags = {
    Name = "zookeeper"
    component = "controller"
  }
}
# attaching ec2 instance with ebs volume
resource "aws_volume_attachment" "zookeeper_disk_attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.zookeeper_disk.id
  instance_id = aws_instance.zookeeper.id
}

output "instance_public_ip" {
  description = "Public IP address of the zookeeper EC2 instance"
  value       = aws_instance.zookeeper.public_ip
}

resource "aws_security_group" "zoopkeeper_security_group" {
  name        = "zookeeper-sg"
  description = "Allow TLS inbound traffic"

 ingress {
    description = "http"
    from_port   = var.zookeeper_external_port
    to_port     = 2181
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

output "zookeeper_security_group_id" {
  value = aws_security_group.zoopkeeper_security_group.id
}

output "zookeeper_external_port" {
  value = var.zookeeper_external_port
}

output "zookeeper_public_ip" {
  value = aws_instance.zookeeper.public_ip
}