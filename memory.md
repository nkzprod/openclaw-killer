# OpenClaw Killer 项目记忆

## 项目背景

- 用户：orange（产品经理，不会写代码）
- 目标：创建一个简单易用的 OpenClaw 卸载工具
- 核心理念：极致简单，单点击穿

## 项目文件

- `openclaw-killer.sh` - 主卸载脚本
- `龙虾卸载指南.md` - 原始卸载指南文档
- `README.md` - 使用说明
- `memory.md` - 项目记忆（本文件）
- `log.md` - 改动日志

## 技术实现

- 使用 Bash 脚本（支持 macOS 和 Linux）
- 自动检测系统和 CLI 状态
- 智能选择简易路径或手动清理路径
- 带颜色的进度提示，用户体验友好

## 卸载逻辑

OpenClaw 有两条卸载路径：

1. **简易路径**（CLI 可用）：
   - 停止网关服务
   - 卸载网关服务
   - 删除状态目录
   - 删除 workspace
   - 卸载 CLI
   - 删除桌面版

2. **手动清理路径**（CLI 不可用）：
   - macOS: 清理 launchctl 服务
   - Linux: 清理 systemd 服务
   - 删除所有配置和状态文件

## 注意事项

- 支持多 profile 配置清理
- 兼容老版本 OpenClaw 遗留文件
- 不需要 sudo 权限
- 所有操作都有错误处理
