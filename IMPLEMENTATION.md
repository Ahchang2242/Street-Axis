# 网站样式改造实现文档

## 项目概述
本文档详细说明了对Street Axis项目进行样式改造的实现方案，参考了"山海间隐居"网站的现代简约度假风格设计。

---

## 一、设计原则与风格指南

### 1.1 配色方案
采用米白、浅褐、深灰、暗金的配色体系：

- **主色调（基底色）**：
  - 米白色：`#FAF8F5` - 页面背景
  - 浅褐色：`#D4C4A8` - 辅助强调色
  
- **文字与元素色**：
  - 深灰色：`#4A4A4A` - 主要文字
  - 中灰色：`#6B6B6B` - 次要文字
  - 浅灰色：`#8B8B8B` - 辅助文字
  
- **强调色**：
  - 暗金色/褐棕色：`#8B7355` - 按钮、链接强调
  - 深褐棕色：`#6B5B45` - 悬停状态

### 1.2 字体系统
- **主要字体**：Georgia, 'Noto Serif SC', serif
- **字体粗细**：主要使用300（细体）和400（常规）
- **字间距**：适当增加字母间距（0.5px-3px）营造高级感
- **行高**：1.8-1.9倍，提升可读性

### 1.3 间距与布局
- **页面内边距**：增大到120px（桌面端）
- **卡片间距**：40px
- **内容内边距**：28px
- **圆角**：主要使用2px（方形圆角），头像使用50%

---

## 二、关键样式实现

### 2.1 导航栏
```css
.navbar {
  background-color: rgba(250, 248, 245, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(139, 115, 85, 0.1);
  transition: all 0.4s ease;
}
```

- 使用毛玻璃效果（backdrop-filter）
- 滚动时背景色加深并添加阴影
- 增大内边距和logo尺寸

### 2.2 轮播图
```css
.carousel-slide::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, rgba(139, 115, 85, 0.3) 0%, rgba(250, 248, 245, 0.1) 100%);
  z-index: 1;
}
```

- 添加渐变遮罩层，统一图片色调
- 增大标题和副标题尺寸
- 按钮采用大写字母和增加字间距

### 2.3 卡片组件
```css
.category-card {
  background-color: #FFFFFF;
  border-radius: 2px;
  box-shadow: 0 2px 20px rgba(139, 115, 85, 0.08);
  transition: all 0.4s ease;
  border: 1px solid rgba(139, 115, 85, 0.05);
}
```

- 轻微的边框和柔和的阴影
- 悬停时提升效果更明显
- 图片应用filter滤镜（brightness、contrast）
- 按钮采用透明背景+边框的设计

### 2.4 页脚
```css
.footer {
  background-color: #4A4A4A;
  color: #FAF8F5;
}
```

- 深灰背景搭配米白文字
- 社交媒体链接使用圆形设计
- 订阅表单样式与整体风格统一

---

## 三、Docker测试环境配置

### 3.1 现有Docker配置
项目已包含完整的Docker配置：

- `Dockerfile` - Ruby应用镜像构建
- `docker-compose.yml` - 多容器编排配置
- `README_DOCKER.md` - 详细部署说明

### 3.2 服务架构
```
┌─────────────────────────────────────────┐
│          Nginx (端口80)                 │
│           ↓                             │
│      Rails 应用 (端口3000)              │
│        ↙     ↘                          │
│   MySQL (3306)  Redis (6379)          │
└─────────────────────────────────────────┘
```

### 3.3 启动步骤

**1. 启动Docker Desktop**
```bash
# macOS
open -a Docker
```

**2. 构建并启动所有容器**
```bash
cd /path/to/project
docker-compose up --build -d
```

**3. 等待服务启动**
首次启动需要3-5分钟，系统会自动：
- 构建Ruby应用镜像
- 启动MySQL和Redis
- 创建数据库并执行迁移
- 启动Rails服务器

**4. 访问应用**
- 网站地址：http://localhost
- 或直接访问：http://localhost:3000

**5. 常用命令**
```bash
# 查看容器状态
docker-compose ps

# 查看日志
docker-compose logs web

# 停止容器
docker-compose down

# 重启容器
docker-compose restart
```

### 3.4 数据持久化
- MySQL数据：`mysql_data` 卷
- Redis数据：`redis_data` 卷
- Ruby依赖：`bundle` 卷

---

## 四、响应式设计适配

### 4.1 断点设置
- **桌面端**：> 768px
- **平板端**：768px - 480px
- **移动端**：< 480px

### 4.2 适配策略
- 导航菜单在小屏幕隐藏
- 字体大小按比例缩小
- 卡片布局改为单列
- 按钮和输入框尺寸适当调整

---

## 五、交互效果优化

### 5.1 过渡动画
- 所有交互元素使用 `0.3s - 0.4s` ease过渡
- 悬停时添加轻微的transform和阴影变化

### 5.2 视觉反馈
- 按钮悬停：背景色变化 + 轻微上移
- 卡片悬停：阴影加深 + 上移8px
- 图片悬停：1.08倍缩放

---

## 六、文件修改清单

主要修改文件：
- `app/views/home/index.html.erb` - 首页完整样式重写

---

## 七、注意事项

1. **内容保持不变**：仅修改样式，保留原有的街舞相关内容
2. **展示型网站**：简化为展示型，保持现有功能
3. **代码风格**：尽量遵循原有代码结构
4. **浏览器兼容性**：使用现代CSS特性，确保主流浏览器支持

---

## 八、后续优化建议

1. 添加更多页面的样式统一
2. 优化图片加载性能
3. 添加更多交互动画
4. 考虑深色模式支持

---

**文档版本**：v1.0  
**最后更新**：2026-02-27
