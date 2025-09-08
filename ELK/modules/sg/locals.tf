locals {

  #WebApp ingress from CIDR blocks
  webapp_ingress_cidr_rules = flatten([
    for rule in var.webapp_cidr_rules : {
      from_port   = can(regex("-", rule[1])) ? tonumber(split("-", rule[1])[0]) : tonumber(rule[1])
      to_port     = can(regex("-", rule[1])) ? tonumber(split("-", rule[1])[1]) : tonumber(rule[1])
      protocol    = rule[2]
      cidr_blocks = rule[0]
      description = try(rule[3], "Allow ${rule[1]} from ${rule[0]}")
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
