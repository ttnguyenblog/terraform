resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.path_to_public_key)
}

resource "aws_instance" "instances" {

  count = var.create_webapp ? length(var.webapp_instance_types) : 0

  ami           = var.ami_id
  instance_type = var.webapp_instance_types[count.index]

  subnet_id              = var.public_subnets_id[count.index % length(var.public_subnets_id)]
  vpc_security_group_ids = var.security_group_id

  key_name = aws_key_pair.key_pair.key_name

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }

  provisioner "file" {
    source      = "installNginx.sh"
    destination = "/tmp/installNginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installNginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/installNginx.sh", # Remove the spurious CR characters.
      "sudo /tmp/installNginx.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.path_to_private_key)
  }
}
