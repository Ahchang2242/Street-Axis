-- 初始化数据库
CREATE DATABASE IF NOT EXISTS hiphop_website_development CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 授权用户（MySQL 8.0语法）
GRANT ALL PRIVILEGES ON hiphop_website_development.* TO 'root'@'%';
FLUSH PRIVILEGES;
