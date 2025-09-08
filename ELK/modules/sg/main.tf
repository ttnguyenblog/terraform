resource "aws_security_group" "sg" {
  name        = var.name_sg
  description = var.description_sg
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
  for_each = {
    for idx, rule in local.webapp_ingress_cidr_rules : idx => rule
  }

  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = each.value.cidr_blocks
  from_port         = each.value.from_port
  ip_protocol       = each.value.protocol
  to_port           = each.value.to_port
  description       = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = local.default_egress_rule.cidr_blocks
  ip_protocol       = local.default_egress_rule.protocol
  from_port         = local.default_egress_rule.from_port
  to_port           = local.default_egress_rule.to_port
  description       = local.default_egress_rule.description
}





