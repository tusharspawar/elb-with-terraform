variable "region" {
    description = "AWS Region"
    type = string

    default = "us-east-1"  
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "elb_name" {
    description = "ELB Name"
    type = string
}

variable "elb_subnets" {
    description = "List of subnet IDs to attach to the ELB"
    type = list(string)
}

variable "elb_access_logs" {
    description = "Access Log shipping details for ELB logs"
    type = object({
        bucket        = string
        bucket_prefix = string
        interval      = number
    })
}

variable "elb_listener_ssl" {
    description = "SSL Request Listener for the ELB"
    type = object({
        instance_port      = number
        instance_protocol  = string
        lb_port            = number
        lb_protocol        = string
        ssl_certificate_id = string
    })
}

variable "elb_health_check" {
    description = "Target health check for ELB"
    type = object({
        healthy_threshold   = number
        unhealthy_threshold = number
        timeout             = number
        interval            = number
        target              = string
    })

    default = {
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 2
        target              = "HTTP:8080/health"
        interval            = 10
    }
}

variable "elb_sg_name" {
    description = "ELB security group name"
    type = string
}

variable "elb_sg_description" {
    description = "ELB security group description"
    type = string
}

variable "elb_sg_ingress_rules" {
    description = "ELB targets security group name"
    type = object({
        from_port         = number
        to_port           = number
        protocol          = string
        cidr_blocks       = list(string)
      })
}

variable "elb_target_sg_name" {
    description = "ELB targets security group name"
    type = string
}

variable "elb_target_sg_description" {
    description = "ELB targets security group description"
    type = string
}

variable "elb_target_sg_ingress_rules" {
    description = "ELB targets security group name"
    type = object({
        from_port         = number
        to_port           = number
        protocol          = string
      })
}

variable "tags" {
    description = "Tags assigned to the resource"
    type = object({})

    default = {
        Service = "test_service"
    }
}
