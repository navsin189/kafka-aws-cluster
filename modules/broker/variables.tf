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

variable "broker_config_file" {
  type        = string
  description = "broker config file path"
  default     = "./modules/broker/server.properties"
}

variable "kickstart_command" {
  type        = list(string)
  description = "broker kickstart command"
}

variable "zookeeper_external_port" {
  type        = string
  description = "zookeeper port open to world"
}

variable "zookeeper_public_ip" {
  type        = string
  description = "zookeeper public ip"
}

variable "broker_id" {
  type        = string
  description = "broker id"
}
