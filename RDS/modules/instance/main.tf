resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.path_to_public_key)
}

resource "aws_instance" "instances" {
  count = var.create_webapp ? length(var.webapp_instance_types) : 0

  ami           = var.ami_id
  instance_type = var.webapp_instance_types[count.index]

  subnet_id              = var.public_subnets_ids[count.index % length(var.public_subnets_ids)]
  vpc_security_group_ids = var.security_group_id

  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}
