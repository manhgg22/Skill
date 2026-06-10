---
name: init-project
description: Đọc repo, xác định stack, điền PROJECT_CONTEXT.md và RUNBOOK.md. Chạy lần đầu khi dùng hệ thống này trên repo mới.
---

Chạy skill `project-onboarding`:

1. Quét cấu trúc thư mục (depth 3).
2. Xác định stack từ manifest files.
3. Xác định commands từ scripts.
4. Điền `docs/PROJECT_CONTEXT.md`, `docs/RUNBOOK.md`, `docs/ARCHITECTURE.md`.
5. Báo cáo tóm tắt.

Sau khi xong, hỏi user: "Có yêu cầu gì muốn làm ngay không?"
