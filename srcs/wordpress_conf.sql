CREATE DATABASE wordpress;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'localhost';
GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'user'@'localhost';
FLUSH PRIVILEGES;