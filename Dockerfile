# 使用Ruby 3.4.5-alpine3.22作为基础镜像
FROM ruby:3.4.5-alpine3.22

# 安装系统依赖
RUN apk add --no-cache build-base mysql-dev nodejs npm tzdata

# 设置工作目录
WORKDIR /app

# 复制应用代码
COPY . .

# 安装Ruby依赖（会自动生成Gemfile.lock）
RUN bundle install --verbose

# 配置环境变量
ENV RAILS_ENV=development
ENV RACK_ENV=development

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["sh", "-c", "bundle install && sleep 10 && bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rails server -b 0.0.0.0"]
