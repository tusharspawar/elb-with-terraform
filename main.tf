terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = var.region
}

module "elb_sg" {
  source = "./security-group"

  name = var.elb_sg_name
  description = var.elb_sg_description
  vpc_id = var.vpc_id

  ingress_rules = [
    {
      from_port         = var.elb_sg_ingress_rules.from_port
      to_port           = var.elb_sg_ingress_rules.to_port
      protocol          = var.elb_sg_ingress_rules.protocol

      sg_with_source_sg = false
      cidr_blocks       = var.elb_sg_ingress_rules.cidr_blocks

      security_group_ids = null
    }
  ]

  resource_tags = var.tags
}

module "elb_target_sg" {
  source = "./security-group"

  name = var.elb_target_sg_name
  description = var.elb_target_sg_description
  vpc_id = var.vpc_id

  ingress_rules = [
    {
      from_port                = var.elb_target_sg_ingress_rules.from_port
      to_port                  = var.elb_target_sg_ingress_rules.to_port
      protocol                 = var.elb_target_sg_ingress_rules.protocol

      sg_with_source_sg        = true
      security_group_ids       = [ module.elb_sg.id ]

      cidr_blocks              = null
    }
  ]

  resource_tags = var.tags
}

module "elb" {
  source = "./elb"

  name = var.elb_name
  subnets = var.elb_subnets
  security_groups = [ module.elb_sg.id ]

  access_logs = var.elb_access_logs
  listener_ssl = var.elb_listener_ssl
  health_check = var.elb_health_check
  resource_tags = var.tags
}
