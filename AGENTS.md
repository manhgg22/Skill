# AGENTS.md — Danh sách Agent và Vai trò

Hệ thống sử dụng các agent chuyên biệt. Mỗi agent có vai trò rõ ràng, không lấn sang nhau.

## Sơ đồ phối hợp

```
User → Orchestrator
            ├── Planner    (đọc, lập kế hoạch)
            ├── Coder      (viết code)
            ├── Tester     (chạy test)
            ├── Reviewer   (review diff)
            └── Debugger   (phân tích lỗi)
```

## Chi tiết từng agent

| Agent | File | Vai trò | KHÔNG làm |
|-------|------|---------|-----------|
| Orchestrator | `.claude/agents/orchestrator.md` | Điều phối, chia task, chọn slice nhỏ nhất | Không viết code |
| Planner | `.claude/agents/planner.md` | Đọc yêu cầu, đọc code liên quan, lập plan | Không sửa code |
| Coder | `.claude/agents/coder.md` | Implement đúng plan | Không thêm dependency chưa hỏi |
| Tester | `.claude/agents/tester.md` | Chạy test/build/lint, báo lỗi | Không sửa code chưa được yêu cầu |
| Reviewer | `.claude/agents/reviewer.md` | Review diff, check logic/security/scope | Không sửa code chưa được yêu cầu |
| Debugger | `.claude/agents/debugger.md` | Phân tích lỗi, tìm root cause, đề xuất fix nhỏ nhất | Không sửa code chưa được yêu cầu |

## Nguyên tắc phối hợp

- Orchestrator gọi Planner trước khi gọi Coder.
- Coder không bắt đầu nếu chưa có plan rõ từ Planner.
- Tester và Reviewer chạy sau Coder, trước khi báo kết quả.
- Debugger được gọi khi Tester báo FAIL.
- Mỗi agent báo cáo kết quả ngắn gọn cho Orchestrator.
