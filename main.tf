terraform {
  required_version = ">=0.12"
}
provider "aws" {
  region  = "us-west-1"
  profile = "default"
}

# Creating ec2 instance 
resource "aws_instance" "wordpress-server" {
  ami                    = var.webserver_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.wordpress-sg.id]
  user_data              = file("install_docker.sh")
  key_name               = "wordpress-ec2"
  tags = {
    "Name" = "Wordpress Website"
  }

  provisioner "file" {
    source      = "./install_docker.sh"
    destination = "/home/ubuntu/install_software.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("wordpress-ec2.pem")
    }
  }
  provisioner "file" {
    source      = "./wp-config.php"
    destination = "/home/ubuntu/wp-config.php"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("wordpress-ec2.pem")
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo su",
      "sudo cp /home/wp-config.php /var/www/html/wordpress/wp-config.php",
      "exit 0"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("wordpress-ec2.pem")
    }
  }
  provisioner "file" {
    source = "./wordpress.conf"
    destination = "/home/ubuntu/test-myblog.com.conf"
    
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("wordpress-ec2.pem")
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo su",
      "sudo cp /home/wordpress.conf /etc/apache2/sites-available/test-myblog.com.conf",
      "sudo a2dissite 000-default",
      "sudo a2ensite test-myblog.com",
      "sudo systemctl apache2 restart",
      "exit 0"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("wordpress-ec2.pem")
    }   
  }
}
