---
name: review
description: Review git diff hiện tại. Dùng: /review
---

Chạy skill `code-review`:

1. Lấy diff: `git diff HEAD` (hoặc `git diff --staged` nếu có staged changes).
2. Nếu không có diff → thông báo "Không có thay đổi nào để review".
3. Review theo dimensions: logic, security, validation, scope creep.
4. Output: Must Fix / Should Fix / Nice to Have.
5. Verdict rõ ràng.

Không sửa code. Chỉ report.
