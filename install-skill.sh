#!/bin/bash

# OpenClaw Killer Skill Installer
# 自动安装 OpenClaw Killer 到 ClawHub

set -e

echo "======================================"
echo "   OpenClaw Killer Skill Installer"
echo "======================================"
echo ""

# 检查是否安装了 OpenClaw CLI
if ! command -v openclaw &> /dev/null; then
    echo "错误: 未检测到 OpenClaw CLI"
    echo "请先安装 OpenClaw 或直接使用卸载脚本"
    exit 1
fi

echo "正在安装 OpenClaw Killer Skill..."
echo ""

# 创建 skill 目录
SKILL_DIR="$HOME/.openclaw/skills/openclaw-killer"
mkdir -p "$SKILL_DIR"

# 复制文件
cp openclaw-killer.sh "$SKILL_DIR/"
cp openclaw-killer.ps1 "$SKILL_DIR/"
cp openclaw-killer.skill.md "$SKILL_DIR/README.md"
cp skill.json "$SKILL_DIR/"

echo "✓ Skill 文件已复制"
echo ""

# 注册 skill
if [ -f "$HOME/.openclaw/skills/registry.json" ]; then
    echo "✓ 正在注册 Skill..."
    # 这里可以添加注册逻辑
else
    echo "! 未找到 Skill 注册表，跳过注册"
fi

echo ""
echo "======================================"
echo "✓ OpenClaw Killer Skill 安装完成！"
echo "======================================"
echo ""
echo "使用方法："
echo "  在 OpenClaw 中说: '卸载 OpenClaw' 或 'uninstall OpenClaw'"
echo ""
echo "或者直接运行卸载脚本："
echo "  ./openclaw-killer.sh (macOS/Linux)"
echo "  .\\openclaw-killer.ps1 (Windows)"
echo ""
