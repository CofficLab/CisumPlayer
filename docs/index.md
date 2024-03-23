---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Cisum"
  text: "听音乐本该如此简单"
  tagline: 打造自己的音乐库
  image: 
    src: images/hero3.png
  actions:
    # - theme: brand
    #   text: Markdown Examples
    #   link: /markdown-examples
    # - theme: alt
    #   text: API Examples
    #   link: /api-examples
    - theme: brand
      text: macOS
      link: https://apps.apple.com/cn/app/cisum/id6466401036
    - theme: brand
      text: iOS
      link: https://apps.apple.com/cn/app/cisum/id6466401036
    - theme: alt
      text: GitHub
      link: https://github.com/YueyiNet/Cisum

features:
  - icon: 🔕
    title: 无需注册、登录、扫码
    details: 打开即用
  - icon: ☁️
    title: iCloud 同步
    details: 针对 iCloud 进行了优化
  - icon: 📺
    title: 优雅简洁的界面
    details: 简洁、明确，无心智负担
  - icon: 🍵
    title: 无广告、无干扰
    details: 尊重用户体验
---

<script setup>
import CustomComponent from './components/CustomComponent.vue'
</script>

<!-- <CustomComponent /> -->

<style>
:root {
  --vp-home-hero-name-color: transparent;
  --vp-home-hero-name-background: -webkit-linear-gradient(120deg, #bd34fe 30%, #41d1ff);

  --vp-home-hero-image-background-image: linear-gradient(-45deg, #bd34fe 50%, #47caff 50%);
  --vp-home-hero-image-filter: blur(44px);
}

@media (min-width: 640px) {
  :root {
    --vp-home-hero-image-filter: blur(56px);
  }
}

@media (min-width: 960px) {
  :root {
    --vp-home-hero-image-filter: blur(68px);
  }
}
</style>
