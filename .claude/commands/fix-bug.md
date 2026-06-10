---
name: fix-bug
description: Tìm root cause, fix nhỏ nhất, chạy lại check. Dùng: /fix-bug <mô tả lỗi hoặc paste error>
argument-hint: "<mô tả lỗi hoặc error message>"
---

Lỗi cần fix: $ARGUMENTS

Chạy skill `fix-bug-loop`:

1. Phân tích error message.
2. Gọi Debugger agent → tìm root cause.
3. Gọi Coder agent → implement fix nhỏ nhất.
4. Gọi Tester agent → chạy check.
5. Nếu FAIL (lần 1-3) → quay lại bước 2.
6. Nếu FAIL sau 3 lần → báo cáo tình trạng, hỏi user hướng đi.
7. Nếu PASS → ghi vào `docs/BUGS.md`.
8. Báo cáo kết quả.
