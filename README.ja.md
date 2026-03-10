# OpenClaw Killer - 完璧なアンインストールツール 🦞

ワンクリックでOpenClawを完璧にアンインストール。ロブスターに優雅にさようなら。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](https://github.com)

![OpenClaw Killer Cover](cover.png)

---

## 📢 ツイート

> 🦞 最近ロブスターに悩まされていませんか？飽きましたか？アンインストールしたいですか？
>
> ちょっと待って！OpenClawのアンインストールサービスが人気になっているそうです - 訪問サービスは1回70ドルです。
>
> しかし、OpenClawのアンインストールはゴミ箱にドラッグするだけではありません。少なくとも5つの複雑な手順が必要です：サービスの停止、設定のクリア、状態の削除、複数のプロファイルの処理...
>
> このプロセス全体を完全にオープンソースの無料ツールにパッケージ化しました — OpenClaw Killer
>
> **70ドル節約 💰**
>
> macOS/Linux/Windowsをサポート、ワンクリックソリューション

## なぜOpenClawをアンインストールするのか？

詳細は [WHY.md](WHY.md) をご覧ください。

簡単に言うと：

- 💰 **高コスト**: 月額料金が1000ドルを超える可能性
- 🔒 **セキュリティリスク**: 数十万のインスタンスが公開インターネットに露出
- 🧠 **AI脳の過負荷**: ツールが多すぎると生産性が低下
- ⚠️ **制御不能**: 専門家でもブレーキを踏めない

## クイックスタート

### macOS / Linux

```bash
curl -O https://raw.githubusercontent.com/orange2ai/openclaw-killer/main/openclaw-killer.sh
chmod +x openclaw-killer.sh
./openclaw-killer.sh
```

### Windows

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/orange2ai/openclaw-killer/main/openclaw-killer.ps1" -OutFile "openclaw-killer.ps1"
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\openclaw-killer.ps1
```

## ライセンス

[MIT License](LICENSE)
