---
name: fast-feature
description: Implement tính năng nhỏ nhất có thể chạy được. Kích hoạt khi user dùng /fast-feature hoặc khi có spec rõ ràng cần implement nhanh.
---

# Fast Feature

Mục tiêu: Ship code chạy được sớm nhất. Không làm thêm bất cứ thứ gì ngoài spec.

## Checklist trước khi code

- [ ] Đã đọc `docs/PROJECT_CONTEXT.md`
- [ ] Đã đọc `docs/RUNBOOK.md` (biết command test/build)
- [ ] Có spec rõ ràng (acceptance criteria)
- [ ] Biết files nào cần sửa (không đoán mò)

Nếu thiếu bất kỳ mục nào, chạy skill tương ứng trước.

## Loop implement

```
1. Xác định slice nhỏ nhất có thể demo được
2. List files cần tạo/sửa (tối thiểu)
3. Implement từng file
4. Chạy scripts/check.sh (hoặc check.ps1)
5. Nếu FAIL → sửa lỗi → quay lại bước 4
6. Nếu PASS → báo cáo
```

## Quy tắc implement

- **Một PR = một behavior thay đổi.** Không nhồi nhiều feature.
- **Không sửa code không liên quan** — dù thấy code xấu.
- **Không thêm package mới** nếu chưa hỏi user.
- **Không tạo abstraction** chưa cần (helper, service, factory...).
- **Không viết comment** giải thích code làm gì.
- Nếu cần mock data tạm, dùng hardcode đơn giản — đừng build data layer chưa cần.

## Khi gặp blocker

Nếu cần sửa code liên quan mà ngoài scope:
→ Ghi chú vào `docs/TASKS.md` mục backlog
→ Tiếp tục implement trong scope

## Output

Sau khi PASS:

```
## Kết quả fast-feature

**Files đã tạo/sửa:**
- `path/to/file` — [mô tả]

**Commands đã chạy:**
- `<command>` → ✅ PASS

**Giả định:**
- [nếu có]

**Rủi ro:**
- [nếu có]

**Bước tiếp theo:**
- [ ] ...
```
