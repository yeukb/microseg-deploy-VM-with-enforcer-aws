resource "aws_instance" "linux_instance" {
  ami                         = data.aws_ami.ubuntu.image_id
  instance_type               = var.vmSize
  key_name                    = var.aws_ssh_key
  monitoring                  = false
  subnet_id                   = aws_subnet.linux_subnet.id
  private_ip                  = var.linux_ip
  vpc_security_group_ids      = [aws_security_group.linux.id]
  associate_public_ip_address = true
  user_data_base64            = base64encode(local.user_data)
  iam_instance_profile        = aws_iam_instance_profile.linux_instance_profile.name

  tags = {
    Name        = var.vmName
    application = "VM Host with Enforcer (AWS)"
    project     = "microsegmentation-lab"
    enforcer    = "yes"
  }
}
