---
name: ship
description: Tổng kết output, chạy test gate, review lần cuối. Dùng: /ship
---

Chạy theo thứ tự:

1. Chạy skill `test-gate` → lint + test + build.
2. Nếu FAIL → báo lỗi, dừng lại. Không tiếp tục ship.
3. Nếu PASS → chạy skill `code-review`.
4. Nếu có Must Fix → báo, dừng lại.
5. Chạy skill `ship-check` → tổng hợp report.
6. Chạy skill `docs-update` → cập nhật TASKS.md, BUGS.md.
7. Xuất ship report cuối cùng.

**Không commit. Không push.** Chờ user xác nhận.

Sau khi report xong, hỏi: "Muốn tôi tạo commit message không?"
