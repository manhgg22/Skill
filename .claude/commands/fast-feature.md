---
name: fast-feature
description: Implement feature nhỏ nhất chạy được. Dùng: /fast-feature <mô tả feature>
argument-hint: "<mô tả feature hoặc tên spec>"
---

Feature cần implement: $ARGUMENTS

Loop:

1. Đọc `docs/PROJECT_CONTEXT.md` và `docs/RUNBOOK.md`.
2. Nếu chưa có spec → chạy `requirement-clarify` skill trước.
3. Gọi Planner agent → lấy plan.
4. Gọi Coder agent → implement theo plan.
5. Gọi Tester agent → chạy check.
6. Nếu FAIL → gọi Debugger → quay lại bước 4.
7. Nếu PASS → gọi Reviewer agent.
8. Chạy `ship-check` skill.
9. Báo cáo kết quả.

Nguyên tắc: Ship slice nhỏ nhất chạy được trước. Không làm tính năng phụ.
