variable "name" {
  description = "Name of the security group"
  type = string
}

variable "description" {
  description = "Description of security group"
  type = string
}

variable "vpc_id" {
  description = "VPC id for security group"
  type = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = list(object({
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_blocks       = list(string)
    security_group_ids = list(string)
    sg_with_source_sg = bool
  }))
}

variable "egress_allow_all" {
  description = "Allow all engress traffic"
  type = bool

  default = true
}

variable "resource_tags" {
  description = "Tags assigned to the ELB"
  type = object({})
}