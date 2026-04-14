# rQ · Claude Code Starter

> 给 Claude Code 一个好的开始。
> 基本设置一步配齐，一行命令搞定。

如果你在手机上看这个页面 — 先点右上角的星星收藏，回家用电脑打开。
下面的操作需要在电脑上完成。

---

## 这是什么？

Claude Code 本身已经很好用了，开箱就能干很多事。但它有不少设置项，新手一上来很难知道该开什么、关什么、怎么调。

这个配置包帮你把基本设置一步配齐 — 中文回复、深度思考、自动记忆、安全防护 — 不用自己一个个去研究。

就像买了一台新电脑，出厂就能用，但有人帮你把常用设置都调好了，用起来会更顺手。

---

## 前提

你的电脑需要满足：

- **macOS** 系统（苹果电脑）
- 已经安装了 **Claude Code**，能正常打开和聊天

还没装 Claude Code？先去 [code.claude.com](https://code.claude.com) 安装。

---

## 一键安装

在 Claude Code 的聊天框里粘贴下面这行，按回车：

```
curl -fsSL https://raw.githubusercontent.com/realQhimself/rQ-claude-code-starter/main/setup.sh | bash
```

脚本会自动完成所有配置。你只需要做一件事：**装完后关掉 Claude Code，重新打开。**

怎么知道配置成功了？跟 Claude 说"帮我写一篇关于时间管理的文章大纲" — 如果它用中文回答，回答有结构、有深度，就说明生效了。

> 放心，这个脚本不会安装任何软件，只是往一个文件夹里放了 3 个文本文件。
> 而且会自动备份你原来的配置，随时可以恢复。

---

## 配置包里有什么？

| 文件 | 做什么的 |
|------|----------|
| `CLAUDE.md` | 给 Claude 的"入职手册" — 告诉它做事的规矩 |
| `settings.json` | 打开 3 个重要开关 — 让 Claude 更认真、有记性、更透明 |
| `settings.local.json` | 安全锁 — 禁止 Claude 做危险操作 |

---

## 每个配置在解决什么问题？

### CLAUDE.md — 8 条行为规范

规则是英文的（Claude 执行英文指令更准确），但每条都有中文注释解释为什么。
你不需要改英文部分 — 规则是给 Claude 读的，注释是给你读的。

---

**你遇到的问题**：Claude 经常用英文回答，看不懂

**这条规则干了什么**：强制 Claude 所有解释、分析、报告都用中文，不管代码和报错是什么语言

**如果没有这条**：Claude 会根据它看到的代码语言来决定用什么语言回复你

---

**你遇到的问题**：Claude 说了一堆技术术语，完全听不懂

**这条规则干了什么**：要求 Claude 用大白话解释，如果非要用技术词就必须立刻解释

**如果没有这条**：Claude 默认你懂技术，会用一堆专业术语

---

**你遇到的问题**：Claude 删了你的文件或者改了不该改的东西

**这条规则干了什么**：禁止 Claude 删除、覆盖、移动任何文件，除非你在聊天里明确同意

**如果没有这条**：Claude 可能在执行任务时"顺手"删掉或覆盖你的文件

---

**你遇到的问题**：Claude 偷偷装了一堆软件

**这条规则干了什么**：要求 Claude 装任何东西之前都告诉你：装什么、为什么要装、从哪下的

**如果没有这条**：Claude 可能直接执行 `pip install` 或 `npm install`，你都不知道发生了什么

---

**你遇到的问题**：Claude 把你的密码或 API 密钥显示在聊天记录里

**这条规则干了什么**：禁止 Claude 在回复里展示密码和密钥，要求它引导你自己填到安全的文件里

**如果没有这条**：Claude 可能在解释代码时直接把密钥贴出来

---

**你遇到的问题**：Claude 很自信地告诉你一个信息，但其实是编的

**这条规则干了什么**：不确定的事必须说"我不确定"，然后主动去搜索

**如果没有这条**：Claude 会很自信地编造事实、URL、数据，而且看起来很像真的

---

**你遇到的问题**：Claude 说"搞定了"，但其实没检查过

**这条规则干了什么**：要求 Claude 做完任务后自己验证 — 运行代码、检查输出、确认文件存在

**如果没有这条**：Claude 经常写完代码就说"完成"，但代码可能根本跑不起来

---

**你遇到的问题**：Claude 遇到报错就来问你怎么办，或者一直用同一个方法死磕

**这条规则干了什么**：要求 Claude 先自己想办法解决，但同一个方法失败两次就换方向去查文档

**如果没有这条**：Claude 要么马上放弃问你，要么用同一个方法试十次都不换

---

### settings.json — 3 个开关

**effortLevel = high**
- 打开前：Claude 自己决定要不要认真想，有时候会偷懒给你一句话的答案
- 打开后：Claude 每次都认真思考，回答更有深度

**autoMemoryEnabled = true**
- 打开前：每次打开 Claude Code 都像第一次见面，它不记得你之前说过什么
- 打开后：Claude 自动记住你的偏好和习惯，下次对话不用重复说

**showThinkingSummaries = true**
- 打开前：Claude 在想什么你完全看不到，像个黑箱
- 打开后：能看到 Claude 的思考过程，知道它有没有在认真干活

### settings.local.json — 安全锁

就像你跟保姆说"不许用我的信用卡、不许扔我的东西"。

这个文件列了 Claude **绝对不许做**的事：

- **不许删你电脑上的文件**（`rm -rf` 命令，6 种写法全堵上了）
- **不许强制覆盖你 GitHub 上的代码**（`git push --force`，3 种写法全堵上了）

就算 Claude 在执行任务时"觉得"需要做这些操作，这个安全锁也会直接拦住它。

---

## 常见问题

**Q: 会不会把电脑搞坏？**

不会。这个脚本只是往一个文件夹里放了 3 个文本文件，不会安装任何软件，不会动你现有的文件。

**Q: 要付钱吗？**

配置包免费。但 Claude Code 本身需要 Anthropic 的付费订阅。

**Q: 装了之后 Claude 还是不听话怎么办？**

先关掉 Claude Code 重新打开。如果还是不行，在聊天框输入 `/memory` 看看有没有加载到你的 CLAUDE.md。

**Q: 我想加自己的规则怎么办？**

在 Finder 里打开 `~/.claude/CLAUDE.md`，在最后面加你的规则就行。写英文效果最好，写中文也能用。

**Q: 英文规则我看不懂，需要改成中文吗？**

不需要。每条英文规则上面都有中文注释解释它在干什么。规则是给 Claude 读的，注释是给你读的。你只需要读懂中文注释就够了。

---

## 如何卸载

安装时自动备份了你原来的文件（带时间戳）。

恢复原来的配置（把下面命令里的 `TIMESTAMP` 换成你安装时的时间戳）：

```bash
cd ~/.claude
mv CLAUDE.md.backup.TIMESTAMP CLAUDE.md
mv settings.json.backup.TIMESTAMP settings.json
mv settings.local.json.backup.TIMESTAMP settings.local.json
```

或者直接删掉配置文件，恢复成 Claude Code 出厂状态：

```bash
rm ~/.claude/CLAUDE.md ~/.claude/settings.json ~/.claude/settings.local.json
```

---

## 关于

by [realQhimself](https://github.com/realQhimself)

如果觉得有用，给这个 repo 点个星星。有问题或建议，欢迎提 [issue](https://github.com/realQhimself/rQ-claude-code-starter/issues)。
