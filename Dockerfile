FROM node:20-alpine AS builder
WORKDIR /app

# 复制依赖和源代码
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# 关键步骤：替换硬编码的IP地址
# 使用 sed 命令将硬编码的IP替换为本地路径或占位符
RUN sed -i 's/http:\/\/39\.96\.115\.139:8000/\/placeholder-image/g' src/**/*.astro src/**/*.js src/**/*.ts 2>/dev/null || true

# 或者替换为本地开发服务器
RUN sed -i 's/39\.96\.115\.139:8000/localhost:3000/g' src/**/* 2>/dev/null || true

# 然后构建
ENV NODE_ENV=production
RUN npm run build