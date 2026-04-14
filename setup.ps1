# rQ Claude Code Starter — Windows 一键配置脚本
# 用法：在 Claude Code 聊天框里粘贴运行，或在 PowerShell 里运行

$ErrorActionPreference = "Stop"

$RepoUrl = "https://raw.githubusercontent.com/realQhimself/rQ-claude-code-starter/main"
$ClaudeDir = "$env:USERPROFILE\.claude"
$Timestamp = Get-Date -Format "yyyyMMddHHmmss"
$BackedUpFiles = @()

Write-Host ""
Write-Host "========================================"
Write-Host "  rQ Claude Code Starter"
Write-Host "  正在配置..."
Write-Host "========================================"
Write-Host ""

# 步骤 1：检查 Claude Code 是否已安装
$claudePath = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claudePath) {
    Write-Host "❌ 没有检测到 Claude Code。" -ForegroundColor Red
    Write-Host ""
    Write-Host "   请先安装 Claude Code，然后再运行这个脚本。"
    Write-Host "   安装方法：https://code.claude.com"
    exit 1
}
Write-Host "✅ 检测到 Claude Code 已安装" -ForegroundColor Green

# 步骤 2：检查配置目录
if (-not (Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
    Write-Host "✅ 创建了配置文件夹" -ForegroundColor Green
} else {
    Write-Host "✅ 配置文件夹已存在" -ForegroundColor Green
}

# 步骤 3：备份现有配置（时间戳命名）
$BackupMade = $false
foreach ($file in @("CLAUDE.md", "settings.json", "settings.local.json")) {
    $filePath = Join-Path $ClaudeDir $file
    if (Test-Path $filePath) {
        Copy-Item $filePath "$filePath.backup.$Timestamp"
        $BackedUpFiles += "$file.backup.$Timestamp"
        $BackupMade = $true
    }
}
if ($BackupMade) {
    Write-Host "✅ 已备份你原来的配置（备份文件名带时间戳 $Timestamp）" -ForegroundColor Green
}

# 步骤 4：下载配置文件
Write-Host ""
Write-Host "⏳ 正在下载配置文件..."
try {
    foreach ($file in @("CLAUDE.md", "settings.json", "settings.local.json")) {
        $url = "$RepoUrl/$file"
        $dest = Join-Path $ClaudeDir $file
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
    }
    Write-Host "✅ 3 个配置文件已下载" -ForegroundColor Green
} catch {
    Write-Host "❌ 下载失败: $_" -ForegroundColor Red
    if ($BackedUpFiles.Count -gt 0) {
        Write-Host ""
        Write-Host "你的原配置已备份（时间戳 $Timestamp）：" -ForegroundColor Yellow
        foreach ($bf in $BackedUpFiles) {
            Write-Host "  $ClaudeDir\$bf"
        }
        Write-Host "  如需恢复，用备份文件替换同名文件即可。"
    }
    exit 1
}

# 步骤 5：验证
Write-Host ""
Write-Host "🔍 验证配置..."
$AllOk = $true
foreach ($file in @("CLAUDE.md", "settings.json", "settings.local.json")) {
    $filePath = Join-Path $ClaudeDir $file
    if ((Test-Path $filePath) -and ((Get-Item $filePath).Length -gt 0)) {
        Write-Host "   ✅ $file" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $file 下载失败" -ForegroundColor Red
        $AllOk = $false
    }
}

Write-Host ""
if ($AllOk) {
    Write-Host "========================================"
    Write-Host "  🎉 配置完成！"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "下一步："
    Write-Host "  1. 关掉 Claude Code，重新打开"
    Write-Host "  2. 跟 Claude 说：「帮我写一篇关于时间管理的文章大纲」"
    Write-Host "  3. 如果它用中文回答、回答有深度 → 配置成功！"
    Write-Host ""
    if ($BackupMade) {
        Write-Host "如果想恢复原来的配置：" -ForegroundColor Yellow
        Write-Host "  cd $ClaudeDir"
        foreach ($file in @("CLAUDE.md", "settings.json", "settings.local.json")) {
            $backupPath = Join-Path $ClaudeDir "$file.backup.$Timestamp"
            if (Test-Path $backupPath) {
                Write-Host "  Move-Item -Force `"$file.backup.$Timestamp`" `"$file`""
            }
        }
        Write-Host ""
    }
} else {
    Write-Host "⚠️  部分文件下载失败，请检查网络后重试。" -ForegroundColor Yellow
    if ($BackedUpFiles.Count -gt 0) {
        Write-Host "你的原配置已备份在 $ClaudeDir（时间戳 $Timestamp）" -ForegroundColor Yellow
    }
    exit 1
}
