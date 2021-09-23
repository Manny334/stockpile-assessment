variable "webserver_ami" {
  default = "ami-0d382e80be7ffdae5"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "db_port" {
  default = "3306"
}
variable "db_host" {
  default = "0.0.0.0"
}
variable "db_username" {
  default = "wordpress"
}
variable "db_password" {
  default = "wordpress"
}
variable "db_name" {
  default = "wordpress"
}