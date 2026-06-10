---
name: ship-check
description: Tổng hợp output cuối, báo file sửa, test result, risk, next task. Kích hoạt khi user dùng /ship hoặc muốn tổng kết một task.
---

# Ship Check

Mục tiêu: Đảm bảo mọi thứ sẵn sàng trước khi commit/deploy. Không commit/push nếu chưa được yêu cầu rõ ràng.

## Checklist trước khi ship

```
[ ] Test gate PASS (lint + test + build)
[ ] Code review đã chạy, không còn Must Fix
[ ] Không có file debug/console.log tạm còn sót
[ ] Không có secret/credential bị hardcode
[ ] docs/TASKS.md đã cập nhật
[ ] docs/BUGS.md đã cập nhật (nếu fix bug)
[ ] Commit message rõ ràng (dùng conventional commits nếu project đã dùng)
```

## Output format

```markdown
## Ship Report

**Task:** [Tên task]
**Date:** [Ngày]

### Files đã thay đổi
- `path/to/file` — [thay đổi gì]

### Test Results
| Check | Result |
|-------|--------|
| Lint | ✅ PASS |
| Tests | ✅ PASS (N passed) |
| Build | ✅ PASS |

### Rủi ro
- [Rủi ro 1 nếu có]

### Việc chưa làm (nếu có)
- [ ] [Backlog item]

### Đề xuất commit message
```
feat: [mô tả ngắn]

[chi tiết nếu cần]
```

### Ready to ship: ✅ / ❌ [Lý do nếu không]
```

## Không làm

- **Không tự commit** nếu user chưa nói "commit" hoặc "push".
- **Không tự push** trong bất kỳ trường hợp nào.
- **Không merge branch** nếu chưa được yêu cầu.
