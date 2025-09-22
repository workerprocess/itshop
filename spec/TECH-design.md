# Technical Design (Support for PRD): IT Shop Mobile App

สถานะ: Draft  
ผู้เขียน: ทีมเทคนิค  
วันที่: 2025-09-22

> เอกสารนี้สนับสนุน PRD โดยสรุปแนวทางเทคนิค ระดับสถาปัตยกรรม ส่วนประกอบหลัก และความเชื่อมโยงกับโค้ดในโปรเจ็กต์ เพื่อใช้สร้างแผนงานใน Speckit

## 1) ภาพรวมสถาปัตยกรรม
- แพลตฟอร์ม: Flutter (iOS/Android)
- สถาปัตยกรรม: Clean Architecture 3 เลเยอร์ (Presentation / Domain / Data)
- State Management: GetX (controllers, bindings, routes)
- Data Sources: Local (assets/json, SharedPreferences), Remote (REST-ready)
- Theming: Light/Dark พร้อมการคงค่าด้วย SharedPreferences

โครงสร้างหลักในโค้ด:
- `mobile_app/lib/core/` ค่าคงที่, errors, network utils, themes/utils
- `mobile_app/lib/data/` models, datasources (local/remote), repositories impl
- `mobile_app/lib/domain/` entities, repositories, usecases
- `mobile_app/lib/presentation/` bindings, controllers, pages, widgets
- `mobile_app/lib/routes/` เส้นทางภายในแอป
- `assets/json/` ข้อมูลจำลอง `products.json`, `categories.json`

## 2) ข้อกำหนดทางเทคนิคหลัก (สอดรับ PRD)
- นำทาง 5 แท็บ: กำหนดที่ `presentation/pages/*` และ `routes/app_pages.dart`
- Home: แสดง Best Sellers / Recommended จาก data source (mock/remote)
- Products: แยกตามหมวดมาตรฐาน IT จาก `assets/json/categories.json`
- Search: ค้นหาและกรองจากชุดข้อมูลในหน่วยความจำ/remote
- Favorites: บันทึกภายในเครื่อง (ไม่ผูกบัญชี สำหรับเวอร์ชันนี้)
- Profile/Settings: เปลี่ยนธีม Light/Dark และคงค่าด้วย SharedPreferences
- Empty States: ข้อความภาษาไทยตาม PRD แสดงผ่าน widgets ส่วนกลาง

## 3) แผนข้อมูลและโมเดล
- Entities: `Product`, `Category`, `ThemeSettings`, `UserPreferences`, `NavigationState`
- Models: การทำซีเรียไลซ์/ดีซีเรียไลซ์ใน `lib/data/models/*`
- แหล่งข้อมูล:
  - Local: `assets/json/*.json`, SharedPreferences (ธีม/รายการโปรด)
  - Remote: รองรับการเชื่อมต่อ REST ผ่าน `core/network/api_client.dart`

## 4) สัญญา/สคีมา (รองรับอนาคต)
- สร้าง OpenAPI สำหรับ endpoints ต่อไป (products, categories, search)
- ตำแหน่ง: `specs/001-mobile-application-it/contracts/`

## 5) เส้นทางและการผูกคอนโทรลเลอร์
- Routing: `routes/app_routes.dart`, `routes/app_pages.dart`
- Controllers: `presentation/controllers/*` จัดการสถานะของแต่ละแท็บ/หน้า
- Bindings: `presentation/bindings/*` ผูก usecases/repositories

## 6) ธีมและ Glass Theme
- ไฟล์: `lib/core/themes/glass_theme.dart` สไตล์ทันสมัย ฉูดฉาด โปร่งใสตามแนว glassmorphism
- รองรับ Light/Dark และการคงค่าธีมผ่าน `ThemeController` + SharedPreferences

## 7) ข้อความหน้าว่าง (Empty States)
- ออกแบบ widget กลางสำหรับข้อความ:
  - หมวดว่าง: "ยังไม่มีข้อมูลที่เกี่ยวข้อง"
  - ค้นหาไม่พบ: "ไม่พบสินค้าที่ตรงกับการค้นหาของคุณ"
  - โปรดว่าง: "ยังไม่มีสินค้าที่บันทึกไว้"

## 8) ประสิทธิภาพและเป้าหมาย
- Startup ภายใน ~2 วินาที (ตาม Quickstart/Tests)
- แอนิเมชัน 60fps, โหลดรูปภาพแบบมีแคช
- การตอบสนองการค้นหาและเลื่อนลื่นไหลบนอุปกรณ์ระดับกลาง

## 9) การทดสอบ
- Unit/Widget/Integration Tests อยู่ภายใต้ `mobile_app/test/`
- สคริปต์รันทดสอบ: `mobile_app/run_tests.sh`
- สถานการณ์ทดสอบอ้างอิง `specs/001-mobile-application-it/quickstart.md`

## 10) Roadmap ทางเทคนิค (หลังเวอร์ชันนี้)
- เพิ่มระบบตะกร้า/ชำระเงิน และบัญชีผู้ใช้เต็มรูปแบบ
- เชื่อมต่อ API จริง พร้อมระบบแคชและรีไทร
- Analytics, Crash reporting, Remote config
- การรองรับหลายภาษาแบบเต็มระบบ (th/en)

## 11) การทำ Mapping ระหว่าง PRD ↔ โค้ด (สั้น)
- PRD: 5 แท็บ → โค้ด: `presentation/pages/*`, `routes/*`
- PRD: หมวดมาตรฐาน IT → โค้ด: `assets/json/categories.json`, models/entities
- PRD: Empty States (ไทย) → โค้ด: `presentation/widgets/*` (empty state widgets)
- PRD: ธีม Light/Dark → โค้ด: `core/themes/*`, `ThemeController`, SharedPreferences
- PRD: Favorites → โค้ด: `UserPreferences` + local storage

## 12) ความเสี่ยงเทคนิคและบรรเทา
- ความหน่วงโหลดรูปภาพ: ใช้แคช/ขนาดภาพเหมาะสม
- ข้อมูลหมวดไม่สอดคล้อง: วางสคีมาและ validation ให้ชัดเจน
- ความซับซ้อนของสถานะ: ใช้ GetX แยก concerns ชัดเจน พร้อมเทสต์


