import { getPermalink, getBlogPermalink, getAsset } from './utils/permalinks';

export const headerData = {
  links: [
    {
      text: '首页',
      links: [
        {
          text: '你的爱情',
          href: getPermalink('/404.astro'),
        },
        {
          text: '你的余额',
          href: getPermalink('/404.astro'),
        },

      ],
    },
   
    {
      text: '博客',
      links: [
        {
          text: '内容',
          href: getBlogPermalink(),
        },
       
      ],
    },
        {
      text: '关于我',
      links: [
        {
          text: '身世',
          href: '#',
        },
        {
          text: '教育经历',
          href: '#',
        },
        {
          text: '未来发展',
          href: '404.astro',
        },
      ],
    },
    {
      text: '联系我',
      links: [
        {
          text: 'QQ',
          href: 'https://user.qzone.qq.com/2817108368',
        },
        {
          text: 'Bilibili',
          href: 'https://space.bilibili.com/208259?spm_id_from=333.337.0.0',
        },
        {
          text: 'Tel 18627927233',
        }
       
      ],
    },
  ],
  actions: [{ text: 'GitHub', href: 'https://github.com/YUAN-27/web', target: '_blank' }],
};

export const footerData = {
  links: [
    {
      title: 'Product',
      links: [
        { text: 'Features', href: '#' },
        { text: 'Security', href: '#' },
        { text: 'Team', href: '#' },
        { text: 'Enterprise', href: '#' },
        { text: 'Customer stories', href: '#' },
        { text: 'Pricing', href: '#' },
        { text: 'Resources', href: '#' },
      ],
    },

  ],
  secondaryLinks: [
    { text: '条款', href: getPermalink('/terms') },
    { text: '隐私政策', href: getPermalink('/privacy') },
  ],
  socialLinks: [
    { ariaLabel: 'bilibili', icon: 'tabler:brand-bilibili', href: 'https://space.bilibili.com/208259?spm_id_from=333.337.0.0' },
    { ariaLabel: 'QQ', icon: 'tabler:brand-qq', href: 'https://user.qzone.qq.com/2817108368' },
    { ariaLabel: 'Youtube', icon: 'tabler:brand-youtube', href: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=RDdQw4w9WgXcQ&start_radio=1' },
    { ariaLabel: 'Wechat', icon: 'tabler:brand-wechat', type:'wechat', qrcode: getAsset('/images/wechat-qrcode.png') , href: '#' },
    { ariaLabel: 'Github', icon: 'tabler:brand-github', href: 'https://github.com/YUAN-27/web' },
  ],
  footNote: `
    Made by <a class="text-blue-600 underline dark:text-muted" href="https://github.com/YUAN-27"> YUAN</a> · 版权所有.
  `,
};
