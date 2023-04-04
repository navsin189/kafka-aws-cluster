terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.region
}

module "zookeeper-instance" {
    source                                = "./modules/controller"
    ami_image_id                          = var.ami_image_id
    ami_instance_type                     = var.ami_instance_type
    key_name                              = var.key_name
    key_name_path                         = var.key_name_path
    av_zone                               = var.av_zone
    kickstart_command                     = var.kickstart_command
}

module "broker-instance" {
    source                                = "./modules/broker"
    broker_id                             = 1
    ami_image_id                          = var.ami_image_id
    ami_instance_type                     = var.ami_instance_type
    key_name                              = var.key_name
    key_name_path                         = var.key_name_path
    av_zone                               = var.av_zone
    kickstart_command                     = var.kickstart_command
    zookeeper_public_ip                   = module.zookeeper-instance.zookeeper_public_ip
    zookeeper_external_port               = module.zookeeper-instance.zookeeper_external_port
}