# OpenClaw Killer - Perfect Uninstallation Tool 🦞

One-click perfect uninstallation of OpenClaw. Say goodbye to the lobster gracefully.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](https://github.com)

![OpenClaw Killer Cover](cover.png)

---

## 📢 Tweet

> 🦞 Getting bombarded by the lobster lately? Tired of it? Want to uninstall?
>
> Wait! I heard that OpenClaw uninstallation services are getting popular - door-to-door service costs $70 per visit.
>
> But uninstalling OpenClaw isn't just dragging it to the trash. It requires at least 5 complex steps: stop services, clear configs, delete state, handle multiple profiles...
>
> I've packaged this entire process into a completely open-source, free tool — OpenClaw Killer
>
> **Save yourself $70 💰**
>
> Supports macOS/Linux/Windows, one-click solution

For more tweet templates and image prompts, see [tweet.md](tweet.md)

---

## Why Uninstall OpenClaw?

If you want to understand why more and more people are choosing to uninstall OpenClaw, please read [WHY.md](WHY.md).

In short:

- 💰 **High Cost**: Monthly fees can exceed $1000
- 🔒 **Security Risks**: Hundreds of thousands of instances exposed on the public internet
- 🧠 **AI Brain Overload**: Too many tools actually reduce productivity
- ⚠️ **Loss of Control**: Even experts can't hit the brakes

## Quick Start

### macOS / Linux

```bash
# Download script
curl -O https://raw.githubusercontent.com/orange2ai/openclaw-killer/main/openclaw-killer.sh

# Add execute permission
chmod +x openclaw-killer.sh

# Run
./openclaw-killer.sh
```

### Windows

```powershell
# Download script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/orange2ai/openclaw-killer/main/openclaw-killer.ps1" -OutFile "openclaw-killer.ps1"

# If you encounter execution policy restrictions, run first
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Run
.\openclaw-killer.ps1
```

## Features

✓ Supports three major platforms (macOS / Linux / Windows)
✓ Automatically detects if CLI is available
✓ Intelligently selects uninstallation path
✓ Cleans all residual files
✓ Supports multiple profile configurations
✓ Clear progress indicators

## What It Does

This tool automatically completes all the following steps:

1. Stop gateway service
2. Uninstall gateway service
3. Delete state and configuration files
4. Delete workspace
5. Uninstall CLI (npm/pnpm/bun)
6. Delete macOS desktop app
7. Clean multiple profile residuals

## Security Notes

- All operations are performed in the user directory
- No sudo privileges required
- Checks if files exist before deletion
- Provides clear operation feedback

## Acknowledgments

The WHY document content references AppSo's in-depth report: [Monthly Salary of 20,000, Can't Afford an OpenClaw](https://mp.weixin.qq.com/s/WLgbbLsyR8FZaVXNI0ROyQ)

Thanks to the AppSo team for their in-depth analysis of OpenClaw's cost and security issues.

## License

[MIT License](LICENSE)

---

Say goodbye to OpenClaw gracefully. It's that simple.
