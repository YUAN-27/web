#!/bin/bash
# AstroWind 部署诊断脚本

echo "=========================================="
echo "AstroWind Docker 部署诊断"
echo "=========================================="

echo -e "\n1. 检查项目文件..."
if [ -f "Dockerfile" ]; then
    echo "✓ Dockerfile 存在"
else
    echo "✗ Dockerfile 不存在！"
fi

if [ -f "package.json" ]; then
    echo "✓ package.json 存在"
else
    echo "✗ package.json 不存在！"
fi

echo -e "\n2. 检查本地构建（可选）..."
if [ -d "dist" ]; then
    echo "✓ dist 目录存在"
    echo "  文件数量: $(find dist -type f | wc -l)"
    ls -lh dist/ | head -10
else
    echo "ℹ dist 目录不存在（正常，Docker会构建）"
fi

echo -e "\n3. 检查运行中的容器..."
if docker ps | grep -q astrowind; then
    echo "✓ astrowind 容器正在运行"
    docker ps | grep astrowind
else
    echo "✗ astrowind 容器未运行"
fi

echo -e "\n4. 检查容器内容..."
if docker ps | grep -q astrowind; then
    echo "检查容器内 nginx html 目录："
    docker exec astrowind ls -la /usr/share/nginx/html | head -20
    
    echo -e "\n检查 index.html 前20行："
    docker exec astrowind cat /usr/share/nginx/html/index.html 2>/dev/null | head -20
else
    echo "容器未运行，跳过检查"
fi

echo -e "\n5. 测试访问..."
if docker ps | grep -q astrowind; then
    echo "测试 HTTP 响应："
    curl -I http://localhost:8000 2>/dev/null | head -5
    
    echo -e "\n检查页面标题："
    curl -s http://localhost:8000 2>/dev/null | grep -i "<title>" | head -1
fi

echo -e "\n=========================================="
echo "诊断完成"
echo "=========================================="
