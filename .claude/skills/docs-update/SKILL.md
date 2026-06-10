---
name: docs-update
description: Cập nhật TASKS, BUGS, DECISIONS, ARCHITECTURE khi có thay đổi đáng ghi nhận. Không viết docs lan man. Kích hoạt sau task hoàn thành hoặc khi user yêu cầu cập nhật docs.
---

# Docs Update

Mục tiêu: Giữ docs luôn phản ánh trạng thái thực, không để docs stale.

## Khi nào cập nhật gì

| Sự kiện | File cần cập nhật |
|---------|------------------|
| Task hoàn thành | `docs/TASKS.md` → move sang Done |
| Bug fix | `docs/BUGS.md` → move sang Fixed |
| Quyết định kỹ thuật | `docs/DECISIONS.md` → thêm entry |
| Thêm thành phần mới | `docs/ARCHITECTURE.md` → cập nhật sơ đồ |
| Stack thay đổi | `docs/PROJECT_CONTEXT.md` → cập nhật |
| Thêm command | `docs/RUNBOOK.md` → thêm command |

## Quy tắc viết docs

- **Ngắn gọn** — mỗi entry tối đa 5 dòng.
- **Factual** — ghi sự thật, không giải thích dài.
- **No essay** — không viết paragraph giải thích triết lý.
- **Dated** — mọi entry có ngày tháng.

## Không làm

- Không viết lại toàn bộ file nếu chỉ cần thêm 1 dòng.
- Không duplicate thông tin đã có.
- Không viết docs về những gì user có thể đọc trực tiếp trong code.

## Output

```
## Docs Updated

- `docs/TASKS.md` → moved [task] to Done
- `docs/BUGS.md` → added fix #3
(không báo cáo gì nếu không có thay đổi)
```
