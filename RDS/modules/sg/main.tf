### Security Group for Web Application
resource "aws_security_group" "webapp_sg" {
  name        = var.webapp_sg_name
  description = var.description_webapp_sg
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_webapp" {
  for_each = {
    for idx, rule in local.webapp_ingress_cidr_rules : idx => rule
  }

  security_group_id = aws_security_group.webapp_sg.id
  cidr_ipv4         = each.value.cidr_blocks
  from_port         = each.value.from_port
  ip_protocol       = each.value.protocol
  to_port           = each.value.to_port
  description       = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_webapp" {
  security_group_id = aws_security_group.webapp_sg.id
  cidr_ipv4         = local.default_egress_rule.cidr_blocks
  ip_protocol       = local.default_egress_rule.protocol
  description       = local.default_egress_rule.description
}

### Security Group for Database
resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = var.description_rds_sg
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_rds" {
  for_each = {
    for idx, rule in local.rds_ingress_sg_rules : idx => rule
  }

  security_group_id = aws_security_group.rds_sg.id
  referenced_security_group_id = each.value.source_security_group_id
  from_port         = each.value.from_port
  ip_protocol       = each.value.protocol
  to_port           = each.value.to_port
  description       = each.value.description
}

resource "aws_vpc_security_group_egress_rule" "egress_rule_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = local.default_egress_rule.cidr_blocks
  ip_protocol       = local.default_egress_rule.protocol
  description       = local.default_egress_rule.description
}



