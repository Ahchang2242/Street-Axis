# 街舞网站 Docker 部署说明

## 项目简介

这是一个基于 Ruby on Rails 框架开发的街舞主题网站，包含完整的用户认证系统和首页模块。项目使用 Docker 容器化部署，集成了 MySQL 数据库和 Redis 缓存服务。

## 技术栈

- **Ruby on Rails 5.2**：Web 应用框架
- **MySQL 5.7**：关系型数据库
- **Redis 6.0**：缓存和会话存储
- **Docker**：容器化平台
- **Docker Compose**：多容器协调部署

## 环境配置

### 1. 前提条件

- 安装 Docker：[Docker 官方安装指南](https://docs.docker.com/get-docker/)
- 安装 Docker Compose：[Docker Compose 官方安装指南](https://docs.docker.com/compose/install/)

### 2. 环境变量

项目使用 `.env` 文件存储环境变量，默认配置如下：

```env
# Environment variables for development
RAILS_ENV=development
RACK_ENV=development

# Database configuration
DATABASE_URL=mysql2://root:password@db:3306/hiphop_website_development

# Redis configuration
REDIS_URL=redis://redis:6379/0

# Secret key base
SECRET_KEY_BASE=development_secret_key_base
```

## 部署步骤

### 1. 构建和启动容器

在项目根目录执行以下命令：

```bash
# 构建并启动所有容器
docker-compose up --build

# 后台运行容器（可选）
docker-compose up --build -d
```

### 2. 等待服务启动

首次启动时，系统会：
1. 构建 Ruby 应用镜像
2. 启动 MySQL 和 Redis 服务
3. 创建数据库并执行迁移
4. 启动 Rails 服务器

服务启动后，可以通过以下地址访问：
- **网站地址**：http://localhost:3000
- **MySQL 数据库**：localhost:3306（用户名：root，密码：password）
- **Redis 服务**：localhost:6379

### 3. 查看容器状态

```bash
# 查看容器状态
docker-compose ps

# 查看服务日志
docker-compose logs

# 查看 Rails 应用日志
docker-compose logs web
```

### 4. 停止和重启容器

```bash
# 停止所有容器
docker-compose down

# 重启所有容器
docker-compose restart
```

## 数据持久化

项目配置了数据持久化方案，确保容器重启后数据不丢失：

- **MySQL 数据**：存储在 `mysql_data` 卷中
- **Redis 数据**：存储在 `redis_data` 卷中
- **Ruby 依赖**：存储在 `bundle` 卷中

## 开发指南

### 1. 进入容器

```bash
# 进入 Rails 应用容器
docker-compose exec web bash

# 进入 MySQL 容器
docker-compose exec db bash

# 进入 Redis 容器
docker-compose exec redis bash
```

### 2. 执行 Rails 命令

```bash
# 在容器中执行 Rails 命令
docker-compose exec web bundle exec rails [command]

# 例如：创建新的控制器
docker-compose exec web bundle exec rails generate controller [name]

# 例如：执行数据库迁移
docker-compose exec web bundle exec rake db:migrate
```

### 3. 代码更新

由于项目使用了卷挂载（`.:/app`），本地代码修改会自动同步到容器中，无需重新构建镜像。

## 故障排除

### 1. 端口冲突

如果端口 3000、3306 或 6379 已被占用，可以修改 `docker-compose.yml` 文件中的端口映射：

```yaml
# 例如：修改 Rails 应用端口
web:
  ports:
    - "3001:3000"
```

### 2. 数据库连接问题

确保 MySQL 服务正常启动，并且数据库配置正确。可以通过以下命令检查：

```bash
# 检查 MySQL 服务状态
docker-compose exec db mysql -u root -ppassword -e "SHOW DATABASES;"
```

### 3. Redis 连接问题

确保 Redis 服务正常启动，可以通过以下命令检查：

```bash
# 检查 Redis 服务状态
docker-compose exec redis redis-cli ping
```

## 生产环境部署

### 1. 修改环境变量

在生产环境中，应修改 `.env` 文件，使用更安全的配置：

```env
RAILS_ENV=production
RACK_ENV=production
SECRET_KEY_BASE=your_production_secret_key
# 其他配置...
```

### 2. 构建生产镜像

```bash
# 构建生产镜像
docker-compose build

# 启动生产容器
docker-compose up -d
```

### 3. 执行生产环境任务

```bash
# 执行数据库迁移
docker-compose exec web bundle exec rake db:migrate RAILS_ENV=production

# 预编译资产
docker-compose exec web bundle exec rake assets:precompile RAILS_ENV=production
```

## 注意事项

1. 本部署方案适用于开发和测试环境，生产环境应使用更安全的配置
2. 首次启动时，系统会自动创建数据库和执行迁移
3. 数据持久化卷在容器删除后仍然存在，确保数据安全
4. 如需重置数据，可以删除持久化卷并重新启动容器

## 常见问题

### Q: 启动容器时出现端口冲突怎么办？
A: 修改 `docker-compose.yml` 文件中的端口映射，使用未被占用的端口。

### Q: 数据库迁移失败怎么办？
A: 检查 MySQL 服务是否正常启动，查看日志了解具体错误信息。

### Q: 如何更新 Ruby 依赖？
A: 修改 `Gemfile` 文件后，重新构建镜像：`docker-compose build`。

### Q: 如何备份数据库？
A: 可以使用 `docker-compose exec db mysqldump` 命令导出数据库。

## 联系信息

如果在部署过程中遇到问题，请联系开发团队获取支持。
