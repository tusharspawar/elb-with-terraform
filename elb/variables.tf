variable "name" {
    description = "ELB Name"
    type = string
}

variable "subnets" {
    description = "List of subnet IDs to attach to the ELB"
    type = list(string)
}

variable "security_groups" {
    description = "List of security group IDs to assign to the ELB"
    type = list(string)
}

variable "access_logs" {
    description = "Access Log shipping for ELB logs"
    type = object({
        bucket        = string
        bucket_prefix = string
        interval      = number
    })
}

variable "listener_ssl" {
    description = "SSL Request Listener for the ELB"
    type = object({
        instance_port      = number
        instance_protocol  = string
        lb_port            = number
        lb_protocol        = string
        ssl_certificate_id = string
    })
}

variable "health_check" {
    description = "Target health check for ELB"
    type = object({
        healthy_threshold   = number
        unhealthy_threshold = number
        timeout             = number
        interval            = number
        target              = string
    })
}

variable "resource_tags" {
    description = "Tags assigned to the ELB"
    type = object({})
}
