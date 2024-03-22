import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Cisum",
  description: "简洁好用的音乐播放器",
  base: "/Cisum/",
  srcDir: "docs",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      // { text: 'Home', link: '/Cisum' },
      // { text: 'Examples', link: '/markdown-examples' }
    ],

    logo: '/images/logo.png',

    sidebar: [
      {
        text: 'Examples',
        items: [
          { text: 'Markdown Examples', link: '/markdown-examples' },
          { text: 'Runtime API Examples', link: '/api-examples' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/YueyiNet/Cisum' }
    ],

    footer: {
      message: 'All rights reserved.',
      copyright: 'Copyright © 2024-present Yueyi Network'
    }
  }
})
