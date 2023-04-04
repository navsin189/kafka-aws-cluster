variable "region"{
    type = string
    default = "ap-south-1"
}

variable "ami_image_id" {
  type        = string
  default     = "ami-05c8ca4485f8b138a"
  description = "AMI image id"
}

variable "ami_instance_type" {
  type        = string
  default     = "t2.medium"
  description = "instance type"
}

variable "av_zone"{
    type = string
    default = "ap-south-1a"
}

variable "key_name" {
    description = "key pair name for login"
    type = string
    sensitive = true
}
variable "key_name_path" {
  type        = string
  description = "description"
  sensitive = true
}

variable "kickstart_command" {
  type        = list(string)
  description = "common command runs on all machine"
  default = [
        "sudo dnf install wget vim net-tools coreutils -y",
        "wget https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.rpm",
        "sudo rpm -ivh jdk-20_linux-x64_bin.rpm",
        "wget https://dlcdn.apache.org/kafka/3.4.0/kafka_2.13-3.4.0.tgz",
        "tar xvf kafka_2.13-3.4.0.tgz",
    ]
}