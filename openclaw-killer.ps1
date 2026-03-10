# OpenClaw Killer - 完美卸载 OpenClaw (Windows 版)
# 让这只龙虾体面告别

# 设置错误处理
$ErrorActionPreference = "Continue"

# 颜色函数
function Write-Step {
    param([string]$Message)
    Write-Host "[步骤] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[成功] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[警告] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[错误] $Message" -ForegroundColor Red
}

# 欢迎信息
Write-Host ""
Write-Host "======================================"
Write-Host "   OpenClaw Killer - 龙虾卸载工具"
Write-Host "======================================"
Write-Host ""
Write-Host "这个工具会帮你完全卸载 OpenClaw"
Write-Host ""

Write-Step "检测到系统: Windows"
Write-Host ""

# 检查 CLI 是否可用
$CLI_AVAILABLE = $false
if (Get-Command openclaw -ErrorAction SilentlyContinue) {
    $CLI_AVAILABLE = $true
    Write-Success "检测到 OpenClaw CLI，将使用简易卸载路径"
} else {
    Write-Warning "未检测到 OpenClaw CLI，将使用手动清理路径"
}

Write-Host ""
Write-Host "准备开始卸载..."
Start-Sleep -Seconds 2
Write-Host ""

# ============================================
# 简易路径（CLI 可用）
# ============================================
if ($CLI_AVAILABLE) {
    Write-Step "1/6 停止网关服务..."
    try {
        openclaw gateway stop 2>$null
        Write-Success "网关服务已停止"
    } catch {
        Write-Warning "网关服务可能已经停止或不存在"
    }
    Write-Host ""

    Write-Step "2/6 卸载网关服务..."
    try {
        openclaw gateway uninstall 2>$null
        Write-Success "网关服务已卸载"
    } catch {
        Write-Warning "网关服务可能已经卸载"
    }
    Write-Host ""

    Write-Step "3/6 删除状态和配置文件..."
    $STATE_DIR = if ($env:OPENCLAW_STATE_DIR) { $env:OPENCLAW_STATE_DIR } else { "$env:USERPROFILE\.openclaw" }
    if (Test-Path $STATE_DIR) {
        Remove-Item -Path $STATE_DIR -Recurse -Force
        Write-Success "已删除: $STATE_DIR"
    } else {
        Write-Warning "状态目录不存在: $STATE_DIR"
    }
    Write-Host ""

    Write-Step "4/6 删除 workspace..."
    $WORKSPACE_DIR = "$env:USERPROFILE\.openclaw\workspace"
    if (Test-Path $WORKSPACE_DIR) {
        Remove-Item -Path $WORKSPACE_DIR -Recurse -Force
        Write-Success "已删除 workspace"
    } else {
        Write-Warning "workspace 不存在"
    }
    Write-Host ""

    Write-Step "5/6 卸载 CLI..."
    $CLI_UNINSTALLED = $false

    # 尝试 npm
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        try {
            $npmList = npm list -g openclaw 2>$null
            if ($LASTEXITCODE -eq 0) {
                npm rm -g openclaw
                Write-Success "已通过 npm 卸载 CLI"
                $CLI_UNINSTALLED = $true
            }
        } catch {}
    }

    # 尝试 pnpm
    if (-not $CLI_UNINSTALLED -and (Get-Command pnpm -ErrorAction SilentlyContinue)) {
        try {
            $pnpmList = pnpm list -g openclaw 2>$null
            if ($LASTEXITCODE -eq 0) {
                pnpm remove -g openclaw
                Write-Success "已通过 pnpm 卸载 CLI"
                $CLI_UNINSTALLED = $true
            }
        } catch {}
    }

    # 尝试 bun
    if (-not $CLI_UNINSTALLED -and (Get-Command bun -ErrorAction SilentlyContinue)) {
        try {
            bun remove -g openclaw 2>$null
            Write-Success "已通过 bun 卸载 CLI"
            $CLI_UNINSTALLED = $true
        } catch {}
    }

    if (-not $CLI_UNINSTALLED) {
        Write-Warning "未能自动卸载 CLI，可能需要手动处理"
    }
    Write-Host ""

    Write-Step "6/6 检查其他残留..."
    Write-Warning "Windows 版暂不支持桌面版检测"
    Write-Host ""

# ============================================
# 手动清理路径（CLI 不可用）
# ============================================
} else {
    Write-Step "1/4 停止并删除 Windows 计划任务..."

    # 默认任务
    try {
        $task = Get-ScheduledTask -TaskName "OpenClaw Gateway" -ErrorAction SilentlyContinue
        if ($task) {
            schtasks /Delete /F /TN "OpenClaw Gateway" 2>$null
            Write-Success "已删除默认网关任务"
        }
    } catch {
        Write-Warning "未找到默认网关任务"
    }

    # 删除 gateway.cmd
    $gatewayCmdPath = "$env:USERPROFILE\.openclaw\gateway.cmd"
    if (Test-Path $gatewayCmdPath) {
        Remove-Item -Path $gatewayCmdPath -Force
        Write-Success "已删除 gateway.cmd"
    }

    Write-Host ""

    Write-Step "2/4 删除状态和配置文件..."
    $openclawDir = "$env:USERPROFILE\.openclaw"
    if (Test-Path $openclawDir) {
        Remove-Item -Path $openclawDir -Recurse -Force
        Write-Success "已删除 $openclawDir"
    } else {
        Write-Warning "目录不存在: $openclawDir"
    }
    Write-Host ""

    Write-Step "3/4 删除 workspace..."
    $workspaceDir = "$env:USERPROFILE\.openclaw\workspace"
    if (Test-Path $workspaceDir) {
        Remove-Item -Path $workspaceDir -Recurse -Force
        Write-Success "已删除 workspace"
    } else {
        Write-Warning "workspace 不存在"
    }
    Write-Host ""

    Write-Step "4/4 检查其他残留..."
    Write-Warning "Windows 版暂不支持桌面版检测"
    Write-Host ""
}

# ============================================
# 清理多 profile 残留
# ============================================
Write-Step "检查多 profile 残留..."
$PROFILE_FOUND = $false

# 查找所有 .openclaw-* 目录
Get-ChildItem -Path $env:USERPROFILE -Directory -Filter ".openclaw-*" -ErrorAction SilentlyContinue | ForEach-Object {
    $profileName = $_.Name -replace '\.openclaw-', ''
    Remove-Item -Path $_.FullName -Recurse -Force
    Write-Success "已删除 profile: $profileName"
    $PROFILE_FOUND = $true

    # 删除对应的计划任务
    try {
        $taskName = "OpenClaw Gateway ($profileName)"
        $task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
        if ($task) {
            schtasks /Delete /F /TN $taskName 2>$null
            Write-Success "已删除 profile 任务: $taskName"
        }
    } catch {}
}

if (-not $PROFILE_FOUND) {
    Write-Warning "未发现多 profile 配置"
}

Write-Host ""
Write-Host "======================================"
Write-Host "✓ OpenClaw 卸载完成！" -ForegroundColor Green
Write-Host "======================================"
Write-Host ""
Write-Host "这只龙虾已经体面告别 🦞"
Write-Host ""

# 自我清理：删除脚本自身
Write-Step "清理卸载工具..."
$ScriptPath = $MyInvocation.MyCommand.Path
if ($ScriptPath -and (Test-Path $ScriptPath)) {
    Start-Sleep -Seconds 1
    Remove-Item -Path $ScriptPath -Force
    Write-Success "卸载工具已自我清理，无毒副作用 ✨"
} else {
    Write-Warning "无法定位脚本文件，请手动删除"
}
Write-Host ""
