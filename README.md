# Claude Code Output System

Bộ cấu hình tái sử dụng cho Claude Code — áp dụng được vào bất kỳ repo nào, enforce workflow có cấu trúc và Orchestrated Looping.

---

## Cách hoạt động

Hệ thống dùng **Orchestrated Looping (Architecture 3)**: một team agent phối hợp nhau cho đến khi goal đạt được — không phải một lần là xong.

```
Goal
  ↓
Orchestrator  ←──────────────────────────┐
  ├── Planner  (Research: đọc code)       │
  ├── Coder    (Coding: implement)        │
  └── Tester   (Testing: chạy test)       │
                    ↓                     │
           Evaluation Agent               │
                    ↓          ↘         │
                  PASS        LOOP ───────┘
                    ↓
                 Deliver
```

**Loop bắt buộc cho mọi task:**
```
Understand → Clarify → Spec → Plan → Implement → Check → Review → Improve → Ship
```

---

## Bắt đầu nhanh

```bash
# 1. Copy system vào repo của bạn
#    Kéo các folder: .claude/ docs/ scripts/ templates/ CLAUDE.md AGENTS.md

# 2. Cấp quyền scripts (Unix/Mac)
chmod +x scripts/check.sh scripts/dev.sh

# 3. Mở repo trong Claude Code, gõ:
```

```
/init-project
```

Claude sẽ đọc codebase, xác định stack, và điền vào `docs/PROJECT_CONTEXT.md` + `docs/RUNBOOK.md`.

---

## Hướng dẫn sử dụng

### Bước 1 — Lần đầu tiên

```
/init-project
```

Chạy một lần khi mới copy system vào repo. Claude đọc toàn bộ code, xác định stack (Node.js / Python / Go / ...), điền docs.

---

### Bước 2 — Nhận yêu cầu mới

**Nếu yêu cầu rõ:**
```
/fast-feature export CSV cho bảng users
```

**Nếu yêu cầu còn mơ hồ:**
```
/clarify tôi muốn thêm login bằng Google
```
→ Claude hỏi tối đa 3 câu → xuất spec rõ → bắt đầu implement.

---

### Bước 3 — Goal lớn nhiều bước

```
/goal-loop xây dựng authentication đầy đủ: register, login, logout, forgot password
```

Claude sẽ:
1. Chia thành task nhỏ
2. Làm từng bước theo Orchestrated Loop
3. Hỏi bạn có tiếp tục không sau mỗi task

---

### Bước 4 — Khi có bug

```
/fix-bug TypeError: Cannot read properties of undefined at UserTable.tsx:42
```

Claude tìm root cause → fix nhỏ nhất → chạy check → báo kết quả.

---

### Bước 5 — Trước khi merge

```
/review
/ship
```

`/review` — Review git diff hiện tại (Must Fix / Should Fix / Nice to Have).
`/ship` — Chạy full checklist trước khi commit.

---

### Lưu trạng thái

```
/checkpoint
```

Ghi lại task đang làm, done, backlog vào `docs/TASKS.md`.

---

## Sales Prospecting Workflow

Tìm khách hàng B2B tiềm năng, score, soạn outreach cá nhân hóa — user duyệt trước khi gửi.

```
/sales-prospect
```

```
/sales-prospect tìm brand và agency cần TVC hoặc branded content, khu vực TP.HCM
```

Workflow tự động: Define ICP → Research Leads → Score A/B/C → Write Messages → Review → Output để bạn duyệt.

| Command | Dùng khi |
|---------|---------|
| `/sales-prospect` | Chạy full workflow tìm lead mới |
| `/sales-outreach` | Viết message cho 1 lead cụ thể |
| `/sales-followup` | Xem follow-up đến hạn hôm nay |
| `/sales-daily-report` | Tổng kết pipeline |

**An toàn:** Không tự gửi. Không bịa data. Chỉ dùng nguồn public. Mọi message đều chờ bạn duyệt.

---

## Tất cả Commands

| Command | Dùng khi nào |
|---------|-------------|
| `/init-project` | Lần đầu trên repo mới |
| `/clarify <yêu cầu>` | Yêu cầu mơ hồ, cần spec rõ |
| `/fast-feature <feature>` | Implement feature nhỏ ngay |
| `/fix-bug <lỗi>` | Có bug cần fix |
| `/goal-loop <goal>` | Goal lớn, nhiều bước |
| `/review` | Review diff trước khi merge |
| `/ship` | Kiểm tra trước commit/push |
| `/checkpoint` | Lưu trạng thái vào TASKS.md |

---

## Skills tự động (không cần gõ)

Claude tự nhận ra tình huống và kích hoạt skill phù hợp:

| Tình huống | Skill tự bật |
|-----------|-------------|
| Paste yêu cầu mới | `requirement-clarify` → `fast-feature` |
| Báo có bug/lỗi | `fix-bug-loop` |
| Trước khi merge | `test-gate` → `code-review` → `ship-check` |
| Repo mới, chưa rõ stack | `project-onboarding` |
| Cần cập nhật docs | `docs-update` |

---

## Chạy kiểm tra thủ công

```bash
# Unix/Mac
bash scripts/check.sh

# Windows
.\scripts\check.ps1
```

Auto-detect stack và chạy lint + test + build. Báo rõ PASS/FAIL từng bước.

```bash
# Khởi động dev server
bash scripts/dev.sh       # Unix/Mac
.\scripts\dev.ps1         # Windows
```

---

## Cấu trúc file

```
.claude/
├── skills/           # Skills tự động (8 skills)
├── agents/           # Agent team: Orchestrator, Planner, Coder,
│                     #   Tester, Evaluation Agent, Reviewer, Debugger
└── commands/         # Slash commands (8 commands)
docs/
├── PROJECT_CONTEXT.md  # Stack, cấu trúc (điền bởi /init-project)
├── RUNBOOK.md          # Commands chạy app/test/build
├── TASKS.md            # Task hiện tại và backlog
├── BUGS.md             # Bug log
├── DECISIONS.md        # Quyết định kỹ thuật
└── ARCHITECTURE.md     # Sơ đồ hệ thống
scripts/
├── check.sh / check.ps1   # Lint + test + build
└── dev.sh / dev.ps1       # Khởi động dev server
templates/
├── FEATURE_SPEC.md
├── BUG_REPORT.md
└── PR_TEMPLATE.md
CLAUDE.md               # Rules và loop bắt buộc
AGENTS.md               # Sơ đồ agent và vai trò
```

---

## Copy sang repo khác

```bash
# Copy các folder này vào repo của bạn:
.claude/
docs/
scripts/
templates/
CLAUDE.md
AGENTS.md

# Rồi chạy:
/init-project
```

---

## License

MIT
