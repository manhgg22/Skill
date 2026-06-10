---
name: checkpoint
description: Ghi lại trạng thái hiện tại. Dùng: /checkpoint
---

Snapshot trạng thái làm việc hiện tại:

1. Chạy `git status` → liệt kê files đã thay đổi.
2. Chạy `git diff --stat` → tóm tắt changes.
3. Cập nhật `docs/TASKS.md`:
   - Task đang làm → ghi rõ trạng thái
   - Task vừa xong → move sang Done
4. Nếu có bug tìm thấy → ghi vào `docs/BUGS.md`.
5. Nếu có quyết định kỹ thuật → ghi vào `docs/DECISIONS.md`.

Output tóm tắt:
```
## Checkpoint [timestamp]

**Đang làm:** [task]
**Files thay đổi:** N files
**Status:** [Mô tả ngắn tình trạng]
**Bước tiếp theo:** [...]
```
