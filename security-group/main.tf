resource "aws_security_group" "this" {
  name = var.name
  description = var.description
  vpc_id = var.vpc_id

  dynamic "ingress" {
	iterator = rule
	for_each = var.ingress_rules
	content {
	  from_port = rule.value.from_port
	  to_port = rule.value.to_port
	  protocol = rule.value.protocol
	  cidr_blocks = rule.value.cidr_blocks
	  security_groups = rule.value.sg_with_source_sg ? rule.value.security_group_ids : null
	}
  }

  tags = var.resource_tags
}


resource "aws_security_group_rule" "egress_allow_all" {
  count = var.egress_allow_all ? 1 : 0
  type = "egress"

  protocol = "-1"
  from_port = -1
  to_port = -1

  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
