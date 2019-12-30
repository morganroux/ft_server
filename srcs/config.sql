CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
CREATE DATABASE db_wordpress;
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'newuser'@'localhost';
