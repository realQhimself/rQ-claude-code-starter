#!/bin/bash
# rQ Claude Code Starter — 一键配置脚本
# 用法：粘贴到 Claude Code 聊天框运行，或在 Terminal 里运行

set -e

REPO_URL="https://raw.githubusercontent.com/realQhimself/rQ-claude-code-starter/main"
CLAUDE_DIR="$HOME/.claude"
TIMESTAMP=$(date +%Y%m%d%H%M%S)

echo ""
echo "========================================"
echo "  rQ Claude Code Starter"
echo "  正在配置..."
echo "========================================"
echo ""

# 步骤 1：检查 Claude Code 是否已安装
if ! command -v claude &> /dev/null; then
    echo "❌ 没有检测到 Claude Code。"
    echo ""
    echo "   请先安装 Claude Code，然后再运行这个脚本。"
    echo "   安装方法：https://code.claude.com"
    exit 1
fi
echo "✅ 检测到 Claude Code 已安装"

# 步骤 2：检查配置目录
if [ ! -d "$CLAUDE_DIR" ]; then
    mkdir -p "$CLAUDE_DIR"
    echo "✅ 创建了配置文件夹"
else
    echo "✅ 配置文件夹已存在"
fi

# 步骤 3：备份现有配置（时间戳命名，不会覆盖之前的备份）
BACKUP_MADE=false
for file in CLAUDE.md settings.json settings.local.json; do
    if [ -f "$CLAUDE_DIR/$file" ]; then
        cp "$CLAUDE_DIR/$file" "$CLAUDE_DIR/$file.backup.$TIMESTAMP"
        BACKUP_MADE=true
    fi
done
if [ "$BACKUP_MADE" = true ]; then
    echo "✅ 已备份你原来的配置（备份文件名带时间戳 $TIMESTAMP）"
fi

# 步骤 4：下载配置文件
echo ""
echo "⏳ 正在下载配置文件..."
curl -fsSL "$REPO_URL/CLAUDE.md" -o "$CLAUDE_DIR/CLAUDE.md"
curl -fsSL "$REPO_URL/settings.json" -o "$CLAUDE_DIR/settings.json"
curl -fsSL "$REPO_URL/settings.local.json" -o "$CLAUDE_DIR/settings.local.json"
echo "✅ 3 个配置文件已下载到 ~/.claude/"

# 步骤 5：验证
echo ""
echo "🔍 验证配置..."
ALL_OK=true
for file in CLAUDE.md settings.json settings.local.json; do
    if [ -f "$CLAUDE_DIR/$file" ] && [ -s "$CLAUDE_DIR/$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file 下载失败"
        ALL_OK=false
    fi
done

echo ""
if [ "$ALL_OK" = true ]; then
    echo "========================================"
    echo "  🎉 配置完成！"
    echo "========================================"
    echo ""
    echo "下一步："
    echo "  1. 关掉 Claude Code，重新打开"
    echo "  2. 跟 Claude 说：「帮我写一篇关于时间管理的文章大纲」"
    echo "  3. 如果它用中文回答、回答有深度 → 配置成功！"
    echo ""
    if [ "$BACKUP_MADE" = true ]; then
        echo "如果想恢复原来的配置："
        echo "  cd ~/.claude"
        echo "  mv CLAUDE.md.backup.$TIMESTAMP CLAUDE.md"
        echo "  mv settings.json.backup.$TIMESTAMP settings.json"
        echo "  mv settings.local.json.backup.$TIMESTAMP settings.local.json"
        echo ""
    fi
else
    echo "⚠️  部分文件下载失败，请检查网络后重试。"
    exit 1
fi
