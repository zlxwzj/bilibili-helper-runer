# bilibili-helper-runer
使用github action持续运行最新版本[BILIBILI-HELPER](https://github.com/JunzhouLiu/BILIBILI-HELPER) (即自动获取最新版本运行)
## 使用
> 以下说明绝大部分来自[BILIBILI-HELPER](https://github.com/JunzhouLiu/BILIBILI-HELPER)说明文档以及图片  
> 细节部分有做根据本项目对应修改  
> 如有问题请结合本文档细节以及[BILIBILI-HELPER](https://github.com/JunzhouLiu/BILIBILI-HELPER)说明文档进行修改（或者提ISSUE）
1. **Fork 本项目**
2. **获取 Bilibili Cookies**
- 浏览器打开并登录 [bilibili 网站](https://www.bilibili.com/)
- 按 F12 打开 「开发者工具」 找到 应用程序/Application -> 存储 -> Cookies
- 找到 `bili_jct` `SESSDATA` `DEDEUSERID` 三项，并复制值，创建对应的 GitHub Secrets。

![图示](docs/IMG/20201012001307.png)

3. **点击项目 Settings -> Secrets -> New Secrets 添加以下 3 个 Secrets。**

| Name       | Value            |
| ---------- | ---------------- |
| DEDEUSERID | 从 Cookie 中获取 |
| SESSDATA   | 从 Cookie 中获取 |
| BILI_JCT   | 从 Cookie 中获取 |

![图示](docs/IMG/20201013210000.png)

4. **开启 Actions 并触发每日自动执行**

**Github Actions 默认处于关闭状态，还大家请手动开启 Actions ，执行一次工作流，验证是否可以正常工作。**

![图示](docs/IMG/workflow_dispatch.png)

**Fork 仓库后，GitHub 默认不自动执行 Actions 任务，请修改 `./github/trigger.json` 文件,将 `trigger` 的值改为 `1`，这样每天就会自动执行定时任务了。**

```patch
{
- "trigger": 0
+ "trigger": 1
}
```

如果需要修改每日任务执行的时间，请修改 `.github/workflows/bilibili-helper.yml`，在第 8 行左右位置找到下如下配置。

```yml
  schedule:
    - cron: '30 10 * * *'
    # cron表达式，Actions时区是UTC时间，所以下午18点要往前推8个小时。
    # 示例： 每天晚上22点30执行 '30 14 * * *'
```

*如果收到了 GitHub Action 的错误邮件，请检查 Cookies 是不是失效了，用户主动清除浏览器缓存，会导致 `BILI_JCT` 和 `DEDEUSERID` 失效*

**请各位使用 Actions 时务必遵守Github条款。不要滥用Actions服务。**

**Please be sure to abide by the Github terms when using Actions. Do not abuse the Actions service.**

### 配置自定义功能

**配置文件位于根目录下 `config.json`**

参数示意

| Key                | Value         | 说明                                                                                                          |
| ------------------ | ------------- | ------------------------------------------------------------------------------------------------------------- |
| numberOfCoins      | [0,5]         | 每日投币数量,默认 5                                                                                           |
| selectLike         | [0,1]         | 投币时是否点赞，默认 0, 0：否 1：是                                                                           |
| ~~watchAndShare~~  | ~~[0,1]~~     | ~~观看时是否分享~~                                                                                            |
| monthEndAutoCharge | [false,true]  | 年度大会员月底是否用 B币券 给自己充电，默认 `true`                                                            |
| devicePlatform     | [ios,android] | 手机端漫画签到时的平台，建议选择你设备的平台 ，默认 `ios`                                                     |
| coinAddPriority    | [0,1]         | 0：优先给热榜视频投币，1：优先给关注的up投币                                                                  |
| userAgent          | 浏览器UA      | 用户可根据部署平台配置，可根据userAgent参数列表自由选取，如果触发了HTTP/1.1 412 Precondition Failed也请修改UA |

userAgent可选参数列表
| 平台      | 浏览器         | userAgent                                                                                                                           |
| --------- | -------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Windows10 | EDGE(chromium) | Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36 Edg/86.0.622.69 |
| Windows10 | Chrome         | Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36                 |
| masOS     | safari         | Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Safari/605.1.15               |
| macOS     | Firefox        | Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:65.0) Gecko/20100101 Firefox/65.0                                                  |
| macOS     | Chrome         | Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36            |

*ps：如果尝试给关注的 up 投币十次后（保不准你关注的是年更up主），还没完成每日投币任务，则切换成热榜模式，给热榜视频投币*

*投币数量代码做了处理，如果本日投币不能获得经验了，则不会投币，每天只投能获得经验的硬币。假设你设置每日投币 3 个，早上 7 点你自己投了 2 个硬币，则十点半时，程序只会投 1 个）*

## 参考
[BILIBILI-HELPER](https://github.com/JunzhouLiu/BILIBILI-HELPER)