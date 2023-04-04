variable "ami_image_id" {
  type        = string
  description = "AMI Image name"
}

variable "ami_instance_type" {
  type        = string
  description = "instance type"
}

variable "key_name" {
  type        = string
  description = "authentication ssh keys"
}

variable "key_name_path" {
  type        = string
  description = "key path"
}

variable "av_zone" {
  type        = string
  description = "availability zone"
}

variable "zookeeper_config_file" {
  type        = string
  description = "zookeeper config file path"
  default     = "./modules/controller/zookeeper.properties"
}

variable "kickstart_command" {
  type        = list(string)
  description = "zookeeper kickstart command"
}

variable "zookeeper_external_port" {
  type        = string
  description = "zookeeper port open to world"
  default     = "2181"
}