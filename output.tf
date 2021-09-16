output "linux_server_ip" {
  value = aws_instance.linux_instance.public_ip
}