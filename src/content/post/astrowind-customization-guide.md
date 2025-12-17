---
title: "AstroWind 个性化网站定制完整指南"
publishDate: 2025-12-16
description: "详细介绍 AstroWind 模板的功能特性和自定义方法，帮助你打造独一无二的个人网站"
category: "教程"
tags: ["astro", "教程", "网站定制", "指南"]
---

# 🎨 AstroWind 个性化网站定制完整指南

欢迎使用 AstroWind！这是一份详细的自定义指南，帮助你从零开始打造属于自己的个性化网站。

---

## 📋 目录

1. [项目结构概览](#项目结构概览)
2. [基础配置](#基础配置)
3. [自定义首页](#自定义首页)
4. [导航菜单配置](#导航菜单配置)
5. [撰写博客文章](#撰写博客文章)
6. [修改样式和主题](#修改样式和主题)
7. [添加自定义组件](#添加自定义组件)
8. [图片资源管理](#图片资源管理)
9. [SEO 优化](#seo-优化)
10. [部署更新](#部署更新)

---

## 📁 项目结构概览

```
web-1/
├── src/
│   ├── assets/              # 静态资源
│   │   ├── images/         # 图片文件
│   │   ├── favicons/       # 网站图标
│   │   └── styles/         # 全局样式
│   ├── components/         # 组件
│   │   ├── blog/          # 博客相关组件
│   │   ├── common/        # 通用组件
│   │   ├── ui/            # UI 基础组件
│   │   └── widgets/       # 页面小部件
│   ├── content/           # 内容文件
│   │   └── post/          # 博客文章 (.md/.mdx)
│   ├── layouts/           # 布局模板
│   ├── pages/             # 页面路由
│   │   ├── index.astro    # 首页
│   │   ├── about.astro    # 关于页
│   │   ├── contact.astro  # 联系页
│   │   └── [...blog]/     # 博客路由
│   ├── utils/             # 工具函数
│   ├── config.yaml        # 网站配置
│   └── navigation.ts      # 导航配置
├── public/                # 公共静态文件
├── nginx/                 # Nginx 配置
└── [配置文件...]

```

---

## ⚙️ 基础配置

### 1. 修改网站基本信息

编辑 `src/config.yaml`：

```yaml
site:
  name: "你的网站名称"
  site: "https://your-domain.com"  # 你的域名
  base: "/"
  trailingSlash: false

metadata:
  title:
    default: "你的网站标题"
    template: "%s — 你的网站"
  description: "网站描述，会显示在搜索引擎"
  
  openGraph:
    site_name: "你的网站名称"
    images:
      - url: "~/assets/images/og-image.png"  # 社交分享图片
        width: 1200
        height: 628

ui:
  theme: "system"  # 主题: system | light | dark
```

### 2. 配置博客设置

在同一文件中：

```yaml
apps:
  blog:
    isEnabled: true
    postsPerPage: 6        # 每页文章数

    post:
      permalink: "/%slug%"  # 文章链接格式
      # 可用变量: %slug%, %year%, %month%, %day%

    list:
      pathname: "blog"      # 博客主路径

    category:
      pathname: "category"  # 分类路径

    tag:
      pathname: "tag"       # 标签路径
```

---

## 🏠 自定义首页

首页文件：`src/pages/index.astro`

### 主要区块结构

```astro
---
// 1. 导入组件
import Hero from '~/components/widgets/Hero.astro';
import Features from '~/components/widgets/Features.astro';
import Content from '~/components/widgets/Content.astro';
// ...

// 2. 设置页面元数据
const metadata = {
  title: '首页标题',
};
---

<Layout metadata={metadata}>
  <!-- 3. 添加各种组件 -->
  <Hero />
  <Features />
  <Content />
</Layout>
```

### Hero 组件（顶部大图区）

```astro
<Hero
  actions={[
    {
      variant: 'primary',
      text: '立即开始',
      href: '/blog',
      icon: 'tabler:rocket',
    },
    { 
      text: '了解更多', 
      href: '#features' 
    },
  ]}
  image={{ 
    src: '~/assets/images/hero.png', 
    alt: '网站主图' 
  }}
>
  <Fragment slot="title">
    欢迎来到我的
    <span class="text-accent">个人网站</span>
  </Fragment>

  <Fragment slot="subtitle">
    这里是副标题，可以写简短的介绍
  </Fragment>
</Hero>
```

### Features 组件（特性展示）

```astro
<Features
  id="features"
  title="我的特色"
  subtitle="网站亮点介绍"
  items={[
    {
      title: '特性 1',
      description: '描述文字',
      icon: 'tabler:code',
    },
    {
      title: '特性 2',
      description: '描述文字',
      icon: 'tabler:palette',
    },
    // 最多 6 个
  ]}
/>
```

---

## 🧭 导航菜单配置

编辑 `src/navigation.ts`

### 顶部导航

```typescript
export const headerData = {
  links: [
    {
      text: '首页',
      href: '/',
    },
    {
      text: '博客',
      href: '/blog',
    },
    {
      text: '关于',
      href: '/about',
    },
    {
      text: '联系',
      href: '/contact',
    },
    // 下拉菜单示例
    {
      text: '更多',
      links: [
        { text: '项目', href: '/projects' },
        { text: '作品', href: '/portfolio' },
      ],
    },
  ],
  actions: [
    { 
      text: '下载简历', 
      href: '/resume.pdf',
      target: '_blank' 
    }
  ],
};
```

### 页脚配置

```typescript
export const footerData = {
  links: [
    {
      title: '产品',
      links: [
        { text: '功能', href: '#' },
        { text: '定价', href: '#' },
      ],
    },
    {
      title: '支持',
      links: [
        { text: '文档', href: '#' },
        { text: '社区', href: '#' },
      ],
    },
  ],
  
  // 社交媒体链接
  socialLinks: [
    { 
      ariaLabel: 'GitHub', 
      icon: 'tabler:brand-github', 
      href: 'https://github.com/YUAN-27' 
    },
    { 
      ariaLabel: 'Twitter', 
      icon: 'tabler:brand-twitter', 
      href: '#' 
    },
  ],
  
  // 页脚注释
  footNote: `
    Made by <a href="https://github.com/YUAN-27">YUAN</a> · All rights reserved.
  `,
};
```

---

## 📝 撰写博客文章

### 1. 创建新文章

在 `src/content/post/` 创建 `.md` 或 `.mdx` 文件：

**文件名示例：** `my-first-post.md`

### 2. 文章格式

```markdown
---
title: "我的第一篇博客"
publishDate: 2025-12-16
description: "这是文章摘要，会显示在列表页"
category: "技术"
tags: ["JavaScript", "Web开发"]
image: "~/assets/images/blog/post-1.jpg"
---

# 标题

这里是正文内容...

## 二级标题

- 列表项 1
- 列表项 2

### 代码示例

\`\`\`javascript
const hello = () => {
  console.log("Hello World!");
}
\`\`\`

### 插入图片

![图片描述](~/assets/images/example.jpg)
```

### 3. Front Matter 字段说明

| 字段 | 必填 | 说明 |
|:---|:---:|:---|
| `title` | ✅ | 文章标题 |
| `publishDate` | ✅ | 发布日期 (YYYY-MM-DD) |
| `description` | ❌ | 文章摘要 |
| `category` | ❌ | 文章分类 |
| `tags` | ❌ | 标签数组 |
| `image` | ❌ | 封面图片 |
| `draft` | ❌ | 是否为草稿 (true/false) |

### 4. 使用 MDX（支持组件）

创建 `.mdx` 文件可以在 Markdown 中使用 React/Astro 组件：

```mdx
---
title: "使用组件的文章"
publishDate: 2025-12-16
---

import Button from '~/components/ui/Button.astro';

# 带组件的文章

这是普通文本。

<Button text="点击我" href="/contact" />

继续写 Markdown...
```

---

## 🎨 修改样式和主题

### 1. 全局样式

编辑 `src/assets/styles/tailwind.css`：

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  /* 自定义字体 */
  body {
    @apply font-sans;
  }
  
  /* 自定义标题 */
  h1 {
    @apply text-4xl font-bold;
  }
}

@layer components {
  /* 自定义按钮 */
  .btn-custom {
    @apply px-6 py-3 bg-blue-600 text-white rounded-lg;
  }
}
```

### 2. 自定义颜色和字体

编辑 `src/components/CustomStyles.astro`：

```astro
<style is:global>
  :root {
    /* 主色调 */
    --aw-color-primary: rgb(30, 58, 138);
    --aw-color-secondary: rgb(24, 24, 27);
    --aw-color-accent: rgb(109, 40, 217);
    
    /* 字体 */
    --aw-font-sans: 'Inter Variable', sans-serif;
    --aw-font-serif: 'Georgia', serif;
    --aw-font-heading: var(--aw-font-sans);
  }

  /* 暗黑模式 */
  .dark {
    --aw-color-primary: rgb(147, 197, 253);
  }
</style>
```

### 3. 修改主题色

直接在 `tailwind.config.js` 中修改（需要手动编辑根目录文件）。

---

## 🧩 添加自定义组件

### 1. 创建新组件

在 `src/components/` 创建 `.astro` 文件：

**示例：** `src/components/custom/MyCard.astro`

```astro
---
interface Props {
  title: string;
  description: string;
  image?: string;
}

const { title, description, image } = Astro.props;
---

<div class="card rounded-lg shadow-lg p-6">
  {image && (
    <img src={image} alt={title} class="w-full h-48 object-cover rounded" />
  )}
  <h3 class="text-2xl font-bold mt-4">{title}</h3>
  <p class="mt-2 text-gray-600">{description}</p>
</div>

<style>
  .card {
    background: white;
    transition: transform 0.3s;
  }
  
  .card:hover {
    transform: translateY(-5px);
  }
</style>
```

### 2. 使用自定义组件

在页面中导入并使用：

```astro
---
import MyCard from '~/components/custom/MyCard.astro';
---

<MyCard 
  title="卡片标题"
  description="卡片描述"
  image="/images/card.jpg"
/>
```

---

## 🖼️ 图片资源管理

### 1. 图片存放位置

**需要优化的图片：** `src/assets/images/`
- 会被 Astro 自动优化
- 支持响应式图片
- 使用 `~/assets/images/xxx.jpg` 引用

**静态图片：** `public/`
- 不会被优化
- 直接通过 URL 访问
- 使用 `/images/xxx.jpg` 引用

### 2. 使用图片组件

```astro
---
import { Image } from 'astro:assets';
import myImage from '~/assets/images/photo.jpg';
---

<!-- 自动优化 -->
<Image 
  src={myImage} 
  alt="描述" 
  width={800}
  height={600}
/>

<!-- 外部图片 -->
<img 
  src="https://example.com/image.jpg" 
  alt="外部图片"
  loading="lazy"
/>
```

### 3. 更换网站图标

替换 `src/assets/favicons/` 中的文件：
- `favicon.ico` - 浏览器标签图标
- `apple-touch-icon.png` - iOS 设备图标
- 其他尺寸的 PNG 文件

---

## 🔍 SEO 优化

### 1. 页面级 SEO

在每个页面设置 metadata：

```astro
---
const metadata = {
  title: '页面标题',
  description: '页面描述（120-160字符）',
  canonical: 'https://your-domain.com/page',
  robots: {
    index: true,
    follow: true,
  },
  openGraph: {
    title: 'OG标题',
    description: 'OG描述',
    type: 'website',
    images: [{
      url: '~/assets/images/og-image.jpg',
      width: 1200,
      height: 630,
    }],
  },
};
---

<Layout {metadata}>
  <!-- 页面内容 -->
</Layout>
```

### 2. 结构化数据

添加 JSON-LD：

```astro
<script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Person",
    "name": "你的名字",
    "url": "https://your-domain.com",
    "sameAs": [
      "https://github.com/YUAN-27",
      "https://twitter.com/yourname"
    ]
  }
</script>
```

---

## 🚀 部署更新

### 本地开发

```bash
# 启动开发服务器
npm run dev

# 访问 http://localhost:4321
```

### 构建测试

```bash
# 构建生产版本
npm run build

# 预览构建结果
npm run preview
```

### 部署到服务器

**步骤 1：提交代码**
```bash
git add .
git commit -m "更新网站内容"
git push origin main
```

**步骤 2：服务器更新**
```bash
# SSH 连接服务器
ssh root@your-server-ip

# 进入项目目录
cd /opt/apps/astrowind

# 拉取最新代码
git pull origin main

# 重新构建容器
docker-compose down
docker-compose up -d --build
```

---

## 📚 常用功能速查

### 修改 Logo

编辑 `src/components/Logo.astro`

### 修改页脚

编辑 `src/components/widgets/Footer.astro`

### 添加 Google Analytics

在 `src/config.yaml` 中：
```yaml
analytics:
  vendors:
    googleAnalytics:
      id: "G-XXXXXXXXXX"
```

### 自定义 404 页面

编辑 `src/pages/404.astro`

### 添加联系表单

使用 `src/pages/contact.astro` 作为模板

---

## 💡 实用技巧

### 1. 快速创建页面

复制现有页面并修改内容

### 2. 组件复用

将常用的 HTML 结构提取为组件

### 3. 样式一致性

使用 Tailwind CSS 的工具类保持风格统一

### 4. 图片优化

- 使用 WebP 格式
- 压缩大图片
- 添加 loading="lazy"

### 5. 性能优化

- 减少外部资源引用
- 使用 CDN
- 启用图片优化

---

## 🐛 常见问题

### Q: 修改后看不到效果？
A: 清除浏览器缓存或使用无痕模式

### Q: 图片不显示？
A: 检查路径是否正确，使用 `~/assets/` 或 `/public/`

### Q: 样式不生效？
A: 确保使用了正确的 Tailwind 类名

### Q: 构建失败？
A: 查看终端错误信息，通常是语法错误或导入路径问题

---

## 📖 参考资源

- [Astro 官方文档](https://docs.astro.build/)
- [Tailwind CSS 文档](https://tailwindcss.com/docs)
- [AstroWind GitHub](https://github.com/arthelokyo/astrowind)
- [Markdown 语法](https://www.markdownguide.org/)

---

## 🎉 开始创作吧！

现在你已经掌握了 AstroWind 的核心功能，开始打造属于你自己的个性化网站吧！

如有问题，欢迎查看项目文档或在 GitHub 上提问。

**祝你创作愉快！** ✨
