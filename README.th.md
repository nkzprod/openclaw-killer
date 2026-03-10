# OpenClaw Killer - เครื่องมือถอนการติดตั้งที่สมบูรณ์แบบ 🦞

ถอนการติดตั้ง OpenClaw อย่างสมบูรณ์แบบด้วยคลิกเดียว บอกลากุ้งมังกรอย่างสง่างาม

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](https://github.com)

![OpenClaw Killer Cover](cover.png)

---

## 📢 ทวีต

> 🦞 ถูกกุ้งมังกรโจมตีมากเกินไปเมื่อเร็วๆ นี้? เบื่อแล้ว? อยากถอนการติดตั้ง?
>
> เดี๋ยวก่อน! ได้ยินว่าบริการถอนการติดตั้ง OpenClaw กำลังได้รับความนิยม - บริการถึงบ้านคิดค่าบริการ 70 ดอลลาร์ต่อครั้ง
>
> แต่การถอนการติดตั้ง OpenClaw ไม่ใช่แค่ลากไปที่ถังขยะ ต้องใช้อย่างน้อย 5 ขั้นตอนที่ซับซ้อน: หยุดบริการ, ล้างการกำหนดค่า, ลบสถานะ, จัดการโปรไฟล์หลายรายการ...
>
> ฉันได้รวมกระบวนการทั้งหมดนี้ไว้ในเครื่องมือโอเพนซอร์สฟรีโดยสมบูรณ์ — OpenClaw Killer
>
> **ประหยัด 70 ดอลลาร์ 💰**
>
> รองรับ macOS/Linux/Windows, โซลูชันคลิกเดียว

## ทำไมต้องถอนการติดตั้ง OpenClaw?

สำหรับรายละเอียดเพิ่มเติม โปรดดู [WHY.md](WHY.md)

โดยสรุป:

- 💰 **ต้นทุนสูง**: ค่าธรรมเนียมรายเดือนอาจเกิน 1000 ดอลลาร์
- 🔒 **ความเสี่ยงด้านความปลอดภัย**: หลายแสนอินสแตนซ์ถูกเปิดเผยบนอินเทอร์เน็ตสาธารณะ
- 🧠 **สมองโอเวอร์โหลด AI**: เครื่องมือมากเกินไปลดประสิทธิภาพการทำงาน
- ⚠️ **สูญเสียการควบคุม**: แม้แต่ผู้เชี่ยวชาญก็เบรกไม่ทัน

## เริ่มต้นอย่างรวดเร็ว

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

## ใบอนุญาต

[MIT License](LICENSE)
