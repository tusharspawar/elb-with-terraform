resource "aws_elb" "web_app" {
  name = var.name
  internal = false
  subnets = var.subnets
  security_groups = var.security_groups

  access_logs {
    bucket        = var.access_logs.bucket
    bucket_prefix = join("/",[var.access_logs.bucket_prefix, var.name])
    interval      = var.access_logs.interval
  }

  listener {
    instance_port      = var.listener_ssl.instance_port
    instance_protocol  = var.listener_ssl.instance_protocol

    lb_port            = var.listener_ssl.lb_port
    lb_protocol        = var.listener_ssl.lb_protocol
    ssl_certificate_id = var.listener_ssl.ssl_certificate_id
  }

  health_check {
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    timeout             = var.health_check.timeout
    target              = var.health_check.target
    interval            = var.health_check.interval
  }

  tags = var.resource_tags
}
