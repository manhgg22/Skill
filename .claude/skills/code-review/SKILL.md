---
name: code-review
description: Review git diff hiện tại. Tìm bug logic, security cơ bản, validation thiếu, scope creep. Kích hoạt khi user dùng /review hoặc trước /ship.
---

# Code Review

Mục tiêu: Tìm vấn đề thực sự, không comment style trivial, không sửa code khi chưa được yêu cầu.

## Lấy diff

```bash
git diff HEAD          # chưa stage
git diff --staged      # đã stage
git diff main...HEAD   # toàn bộ branch
```

## Dimensions review

### 1. Bug Logic
- Điều kiện if/else có đúng không?
- Off-by-one errors?
- Null/undefined/empty string được xử lý chưa?
- Race condition (async code)?

### 2. Security cơ bản
- Input từ user có được validate/escape không?
- SQL injection, XSS?
- Secrets/credentials bị hardcode không?
- Auth check bị bypass không?

### 3. Validation
- Input validation ở boundary (API endpoint, form submit)?
- Error message có leak thông tin nhạy cảm không?

### 4. Scope Creep
- Có sửa code ngoài yêu cầu không?
- Có thêm feature chưa được spec không?

### 5. Maintainability (chỉ báo nếu nghiêm trọng)
- Tên biến/hàm cực kỳ misleading?
- Logic phức tạp không giải thích được?

## Output format

```markdown
## Code Review

### Must Fix 🔴
- `file.ts:42` — [vấn đề] — [tại sao nguy hiểm]

### Should Fix 🟡
- `file.ts:80` — [vấn đề] — [impact]

### Nice to Have 🟢
- `file.ts:15` — [gợi ý nhỏ]

### Tốt 👍
- [Điều gì đáng khen]

### Verdict
[Approve / Request Changes / Needs Discussion]
```

## Rules

- Không sửa code khi chưa được yêu cầu.
- Không comment về style nếu không có eslint/prettier enforce.
- Không quá 10 issues — ưu tiên những gì quan trọng nhất.
