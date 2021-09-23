#! /bin/bash

# Installing Apache and its dependencies. 
sudo apt-get update
sudo apt-get install -y apache2 \
                   php \
                   php-bcmath \
                   php-curl \
                   php-imagick \
                   php-intl \
                   php-json \
                   php-mbstring \
                   php-mysql \
                   php-xml \
                   php-zip


# Starting Apache2 service
sudo systemctl start apache2
sudo systemctl enable apache2

sleep 10 

# Installing Docker 
sudo apt-get install -y docker.io

sleep 5

# Pulling latest mysql image 

sudo docker pull mysql

sleep 5

sudo docker run -d --name wordpress-mysql -e MYSQL_ROOT_PASSWORD=1234 -p 3306:3306 mysql

# Installing mysql client

sudo apt-get install mysql-client-core-8.0

# Installing Wordpress


cd /var/www/html && sudo wget https://wordpress.org/latest.tar.gz

sudo tar -xzvf latest.tar.gz

sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sleep 10 
