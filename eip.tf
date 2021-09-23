resource "aws_eip" "wordpress-ip" {
  instance = aws_instance.wordpress-server.id
  vpc      = true
}