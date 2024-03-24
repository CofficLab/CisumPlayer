import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Coffic",
  description: "简洁好用的音乐播放器",
  base: "/Coffic/",
  srcDir: "docs",
  head: [['link', { rel: 'icon', href: '/Coffic/favicon.ico' }]],
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: '文档', link: '/github-actions' }
    ],

    logo: '/images/logo.png',

    sidebar: [
      {
        text: '文档',
        items: [
          { text: 'GitHub Actions', link: '/github-actions' },
          { text: 'Markdown Examples', link: '/markdown-examples' },
          { text: 'Runtime API Examples', link: '/api-examples' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/YueyiNet/Coffic' }
    ],

    footer: {
      message: 'All rights reserved.',
      copyright: 'Copyright © 2024-present Yueyi Network'
    }
  }
})
