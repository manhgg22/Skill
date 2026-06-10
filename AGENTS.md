# AGENTS.md — Danh sách Agent và Vai trò

Hệ thống dùng **Orchestrated Looping (Architecture 3)**: agent team iterate cùng nhau cho đến khi goal đạt được.

## Sơ đồ phối hợp

```
Goal
  ↓
Orchestrator Agent  ←──────────────────────────┐
(Breaks down the goal)                          │
  ↓                                             │
  ├── Planner  [Research Agent]                 │
  ├── Coder    [Coding Agent]                   │
  └── Tester   [Testing Agent]                  │
                    ↓                           │
           Evaluation Agent                     │
           (Checks quality)                     │
                    ↓              ↘            │
                  PASS           LOOP ──────────┘
                    ↓
                 Deliver

"Teams of agents iterate together until the goal is achieved."
```

## Chi tiết từng agent

| Agent | File | Vai trò trong diagram | KHÔNG làm |
|-------|------|-----------------------|-----------|
| Orchestrator | `.claude/agents/orchestrator.md` | Breaks down goal, điều phối loop, nhận feedback từ Evaluation | Không viết code, không tự đánh giá |
| Planner | `.claude/agents/planner.md` | **Research Agent** — đọc codebase, lập plan | Không sửa code |
| Coder | `.claude/agents/coder.md` | **Coding Agent** — implement theo plan | Không thêm dep chưa hỏi |
| Tester | `.claude/agents/tester.md` | **Testing Agent** — chạy test/lint/build | Không sửa code |
| Evaluation Agent | `.claude/agents/evaluation-agent.md` | **Evaluation Agent** — kiểm tra quality, quyết định PASS/LOOP/ESCALATE | Không tự sửa code |
| Reviewer | `.claude/agents/reviewer.md` | Hỗ trợ Evaluation Agent review diff chi tiết | Không sửa code |
| Debugger | `.claude/agents/debugger.md` | Hỗ trợ Coder phân tích lỗi khi test fail | Không sửa code chưa được yêu cầu |

## Nguyên tắc phối hợp

- Orchestrator gọi Planner (Research) trước khi gọi Coder.
- Coder không bắt đầu nếu chưa có plan từ Planner.
- Tester chạy sau Coder, kết quả gửi lên Evaluation Agent.
- **Evaluation Agent là gate duy nhất** quyết định loop hay deliver — không phải Tester, không phải Orchestrator.
- Khi Evaluation Agent báo LOOP → Orchestrator re-plan → loop lại từ Coder.
- Khi Evaluation Agent báo ESCALATE → dừng, hỏi user.
