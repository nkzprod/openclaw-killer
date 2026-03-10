#!/bin/bash

# OpenClaw Killer - 完美卸载 OpenClaw
# 让这只龙虾体面告别

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_step() {
    echo -e "${BLUE}[步骤]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[成功]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

print_error() {
    echo -e "${RED}[错误]${NC} $1"
}

# 欢迎信息
echo ""
echo "======================================"
echo "   OpenClaw Killer - 龙虾卸载工具"
echo "======================================"
echo ""
echo "这个工具会帮你完全卸载 OpenClaw"
echo ""

# 检测操作系统
OS_TYPE=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
    print_step "检测到系统: macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
    print_step "检测到系统: Linux"
else
    print_error "不支持的操作系统: $OSTYPE"
    exit 1
fi

echo ""

# 检查 CLI 是否可用
CLI_AVAILABLE=false
if command -v openclaw &> /dev/null; then
    CLI_AVAILABLE=true
    print_success "检测到 OpenClaw CLI，将使用简易卸载路径"
else
    print_warning "未检测到 OpenClaw CLI，将使用手动清理路径"
fi

echo ""
echo "准备开始卸载..."
sleep 2
echo ""

# ============================================
# 简易路径（CLI 可用）
# ============================================
if [ "$CLI_AVAILABLE" = true ]; then
    print_step "1/6 停止网关服务..."
    if openclaw gateway stop 2>/dev/null; then
        print_success "网关服务已停止"
    else
        print_warning "网关服务可能已经停止或不存在"
    fi
    echo ""

    print_step "2/6 卸载网关服务..."
    if openclaw gateway uninstall 2>/dev/null; then
        print_success "网关服务已卸载"
    else
        print_warning "网关服务可能已经卸载"
    fi
    echo ""

    print_step "3/6 删除状态和配置文件..."
    STATE_DIR="${OPENCLAW_STATE_DIR:-$HOME/.openclaw}"
    if [ -d "$STATE_DIR" ]; then
        rm -rf "$STATE_DIR"
        print_success "已删除: $STATE_DIR"
    else
        print_warning "状态目录不存在: $STATE_DIR"
    fi
    echo ""

    print_step "4/6 删除 workspace..."
    if [ -d "$HOME/.openclaw/workspace" ]; then
        rm -rf "$HOME/.openclaw/workspace"
        print_success "已删除 workspace"
    else
        print_warning "workspace 不存在"
    fi
    echo ""

    print_step "5/6 卸载 CLI..."
    CLI_UNINSTALLED=false

    # 尝试 npm
    if command -v npm &> /dev/null && npm list -g openclaw &> /dev/null; then
        npm rm -g openclaw
        print_success "已通过 npm 卸载 CLI"
        CLI_UNINSTALLED=true
    # 尝试 pnpm
    elif command -v pnpm &> /dev/null && pnpm list -g openclaw &> /dev/null; then
        pnpm remove -g openclaw
        print_success "已通过 pnpm 卸载 CLI"
        CLI_UNINSTALLED=true
    # 尝试 bun
    elif command -v bun &> /dev/null; then
        bun remove -g openclaw 2>/dev/null || true
        print_success "已通过 bun 卸载 CLI"
        CLI_UNINSTALLED=true
    fi

    if [ "$CLI_UNINSTALLED" = false ]; then
        print_warning "未能自动卸载 CLI，可能需要手动处理"
    fi
    echo ""

    print_step "6/6 删除 macOS 桌面版（如果存在）..."
    if [ "$OS_TYPE" = "macos" ] && [ -d "/Applications/OpenClaw.app" ]; then
        rm -rf "/Applications/OpenClaw.app"
        print_success "已删除 macOS 桌面版"
    else
        print_warning "未找到 macOS 桌面版"
    fi
    echo ""

# ============================================
# 手动清理路径（CLI 不可用）
# ============================================
else
    if [ "$OS_TYPE" = "macos" ]; then
        print_step "1/4 停止并删除 macOS 服务..."

        # 默认 profile
        if launchctl list | grep -q "ai.openclaw.gateway"; then
            launchctl bootout gui/$UID/ai.openclaw.gateway 2>/dev/null || true
            print_success "已停止默认网关服务"
        fi

        if [ -f "$HOME/Library/LaunchAgents/ai.openclaw.gateway.plist" ]; then
            rm -f "$HOME/Library/LaunchAgents/ai.openclaw.gateway.plist"
            print_success "已删除默认服务配置"
        fi

        # 清理老版本遗留
        if [ -f "$HOME/Library/LaunchAgents/com.openclaw.gateway.plist" ]; then
            launchctl bootout gui/$UID/com.openclaw.gateway 2>/dev/null || true
            rm -f "$HOME/Library/LaunchAgents/com.openclaw.gateway.plist"
            print_success "已清理老版本服务"
        fi

        echo ""

    elif [ "$OS_TYPE" = "linux" ]; then
        print_step "1/4 停止并删除 Linux 服务..."

        if systemctl --user list-units | grep -q "openclaw-gateway.service"; then
            systemctl --user disable --now openclaw-gateway.service 2>/dev/null || true
            print_success "已停止默认网关服务"
        fi

        if [ -f "$HOME/.config/systemd/user/openclaw-gateway.service" ]; then
            rm -f "$HOME/.config/systemd/user/openclaw-gateway.service"
            systemctl --user daemon-reload
            print_success "已删除默认服务配置"
        fi

        echo ""
    fi

    print_step "2/4 删除状态和配置文件..."
    if [ -d "$HOME/.openclaw" ]; then
        rm -rf "$HOME/.openclaw"
        print_success "已删除 ~/.openclaw"
    fi
    echo ""

    print_step "3/4 删除 workspace..."
    if [ -d "$HOME/.openclaw/workspace" ]; then
        rm -rf "$HOME/.openclaw/workspace"
        print_success "已删除 workspace"
    fi
    echo ""

    print_step "4/4 删除 macOS 桌面版（如果存在）..."
    if [ "$OS_TYPE" = "macos" ] && [ -d "/Applications/OpenClaw.app" ]; then
        rm -rf "/Applications/OpenClaw.app"
        print_success "已删除 macOS 桌面版"
    fi
    echo ""
fi

# ============================================
# 清理多 profile 残留
# ============================================
print_step "检查多 profile 残留..."
PROFILE_FOUND=false
for dir in "$HOME"/.openclaw-*; do
    if [ -d "$dir" ]; then
        PROFILE_NAME=$(basename "$dir" | sed 's/\.openclaw-//')
        rm -rf "$dir"
        print_success "已删除 profile: $PROFILE_NAME"
        PROFILE_FOUND=true
    fi
done

if [ "$PROFILE_FOUND" = false ]; then
    print_warning "未发现多 profile 配置"
fi

echo ""
echo "======================================"
echo -e "${GREEN}✓ OpenClaw 卸载完成！${NC}"
echo "======================================"
echo ""
echo "这只龙虾已经体面告别 🦞"
echo ""

# 自我清理：删除脚本自身
print_step "清理卸载工具..."
SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"
if [ -f "$SCRIPT_PATH" ]; then
    rm -f "$SCRIPT_PATH"
    print_success "卸载工具已自我清理，无毒副作用 ✨"
else
    print_warning "无法定位脚本文件，请手动删除"
fi
echo ""
