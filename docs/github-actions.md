# GitHub Actions

**问题**

部署文档时遇到报错：

::: danger
Branch "test" is not allowed to deploy to github-pages due to environment protection rules.
:::

解决办法：

::: tip
`Settings/Environments/github-pages/Deployment branches and tags`，添加`test`分支
:::
