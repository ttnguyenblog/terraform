locals {

  sg_name_to_id = {
    "webapp" = aws_security_group.webapp_sg.id
  }

  # WebApp ingress from CIDR
  webapp_ingress_cidr_rules = flatten([
    for rule in var.webapp_cidr_rules : {
      from_port   = can(regex("-", rule[1])) ? tonumber(split("-", rule[1])[0]) : tonumber(rule[1])
      to_port     = can(regex("-", rule[1])) ? tonumber(split("-", rule[1])[1]) : tonumber(rule[1])
      protocol    = rule[2]
      cidr_blocks = rule[0]
      description = try(rule[3], "Allow ${rule[1]} from ${rule[0]}")
    }
  ])


  # RDS ingress from Security Group
  rds_ingress_sg_rules = flatten([
    for rule in var.rds_sg_rules : {
      from_port                = can(regex("-", rule[1])) ? tonumber(split("-", rule[1])[0]) : tonumber(rule[1])
      to_port                  = can(regex("-", rule[1])) ? tonumber(split("-", rule[1])[1]) : tonumber(rule[1])
      protocol                 = rule[2]
      source_security_group_id = contains(keys(local.sg_name_to_id), rule[0]) ? local.sg_name_to_id[rule[0]] : rule[0]
      description              = try(rule[3], "Allow ${rule[1]} from security group ${rule[0]}")
    }
  ])

  # Default egress rule
  default_egress_rule = {
    from_port   = var.default_egress_rule_from_port
    to_port     = var.default_egress_rule_to_port
    protocol    = var.default_egress_rule_protocol
    cidr_blocks = var.default_egress_rule_cidr_blocks
    description = "Allow all outbound traffic"
  }
}
