import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Coffic",
  description: "简洁好用的音乐播放器",
  base: "/Coffic/",
  srcDir: "docs",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      // { text: 'Home', link: '/Coffic' },
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
      { icon: 'github', link: 'https://github.com/YueyiNet/Coffic' }
    ],

    footer: {
      message: 'All rights reserved.',
      copyright: 'Copyright © 2024-present Yueyi Network'
    }
  }
})
