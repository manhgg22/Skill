# SETUP_REPORT.md

**Ngày setup:** 2026-06-10
**Setup bởi:** Claude Code Output System

---

## Stack phát hiện được

| Thành phần | Kết quả |
|-----------|---------|
| Frontend | _Chưa xác định — repo trống_ |
| Backend | _Chưa xác định_ |
| Database | _Chưa xác định_ |
| Package manager | _Chưa xác định_ |
| Framework | _Chưa xác định_ |

> Repo tại thời điểm setup **hoàn toàn trống**. Hệ thống này được thiết kế để dùng lại trên nhiều repo. Chạy `/init-project` trong một repo có code thực để điền thông tin stack.

---

## File đã tạo

### Root
- `CLAUDE.md` — Rules và loop bắt buộc cho Claude
- `AGENTS.md` — Danh sách agent và vai trò

### docs/
- `docs/PROJECT_CONTEXT.md` — Stack và cấu trúc (chờ điền)
- `docs/RUNBOOK.md` — Commands chạy app/test/build (chờ điền)
- `docs/TASKS.md` — Quản lý task
- `docs/BUGS.md` — Log bug
- `docs/DECISIONS.md` — Quyết định kỹ thuật
- `docs/ARCHITECTURE.md` — Sơ đồ hệ thống (chờ điền)
- `docs/OUTPUT_RULES.md` — Quy tắc format output
- `docs/SETUP_REPORT.md` — File này

### .claude/skills/ (7 skills)
- `project-onboarding/SKILL.md` — Đọc repo, điền context
- `requirement-clarify/SKILL.md` — Biến yêu cầu mờ thành spec
- `fast-feature/SKILL.md` — Implement nhỏ nhất chạy được
- `fix-bug-loop/SKILL.md` — Debug, fix, verify
- `test-gate/SKILL.md` — Chạy lint/test/build
- `code-review/SKILL.md` — Review diff
- `ship-check/SKILL.md` — Tổng kết trước ship
- `docs-update/SKILL.md` — Cập nhật docs

### .claude/agents/ (6 agents)
- `orchestrator.md` — Điều phối goal lớn
- `planner.md` — Lập plan
- `coder.md` — Viết code
- `tester.md` — Chạy test
- `reviewer.md` — Review diff
- `debugger.md` — Phân tích lỗi

### .claude/commands/ (8 commands)
- `init-project.md` — `/init-project`
- `clarify.md` — `/clarify <yêu cầu>`
- `fast-feature.md` — `/fast-feature <feature>`
- `fix-bug.md` — `/fix-bug <lỗi>`
- `loop.md` — `/loop <goal>`
- `review.md` — `/review`
- `ship.md` — `/ship`
- `checkpoint.md` — `/checkpoint`

### .claude/
- `settings.json` — Permissions an toàn

### scripts/
- `scripts/check.sh` — Tự phát hiện và chạy test/lint/build (Unix)
- `scripts/check.ps1` — Như trên, cho Windows PowerShell
- `scripts/dev.sh` — Khởi động dev server (Unix)
- `scripts/dev.ps1` — Khởi động dev server (Windows)

### templates/
- `templates/FEATURE_SPEC.md`
- `templates/BUG_REPORT.md`
- `templates/PR_TEMPLATE.md`

---

## Commands đã chạy

| Command | Kết quả |
|---------|---------|
| Inspect repo structure | ✅ — Repo trống, không có code business |
| Tạo file hệ thống | ✅ — 35 files tạo mới |

---

## Rủi ro / Cảnh báo

- **Không có code business** — `docs/PROJECT_CONTEXT.md`, `docs/RUNBOOK.md`, `docs/ARCHITECTURE.md` còn trống. Cần chạy `/init-project` khi dùng trên repo có code.
- **settings.json** — Kiểm tra lại permissions nếu project cần command đặc biệt chưa có trong allowlist.
- **scripts/check.sh** — Cần `chmod +x scripts/check.sh` trên Unix/Mac trước khi chạy.

---

## Việc bạn cần làm tiếp theo

1. **Nếu đây là repo mới (chưa có code):**
   - Bắt đầu code, rồi chạy `/init-project` để Claude đọc và điền context.

2. **Nếu copy sang repo có code:**
   - Copy các folder `.claude/`, `docs/`, `scripts/`, `templates/` sang repo đó.
   - Chạy `/init-project` để Claude đọc repo và điền `PROJECT_CONTEXT.md`, `RUNBOOK.md`, `ARCHITECTURE.md`.

3. **Cấp quyền scripts (Unix/Mac):**
   ```bash
   chmod +x scripts/check.sh scripts/dev.sh
   ```

---

## Cách sử dụng hệ thống

### Lần đầu trên repo mới
```
/init-project
```
Claude sẽ đọc repo, xác định stack, điền PROJECT_CONTEXT và RUNBOOK.

### Nhận yêu cầu mới
```
/clarify Tôi muốn thêm tính năng export CSV cho bảng users
```
Claude sẽ hỏi tối đa 3 câu, rồi xuất spec rõ ràng.

### Implement feature
```
/fast-feature Export CSV cho bảng users
```
Claude sẽ plan → code → test → review → báo kết quả.

### Khi có bug
```
/fix-bug TypeError: Cannot read properties of undefined at UserTable.tsx:42
```
Claude sẽ phân tích, tìm root cause, fix nhỏ nhất, chạy check.

### Goal lớn nhiều bước
```
/loop Xây dựng tính năng authentication đầy đủ: register, login, logout, forgot password
```
Claude sẽ chia thành task nhỏ, làm từng bước, hỏi trước khi tiếp tục.

### Kiểm tra trước khi merge
```
/review
/ship
```

### Ghi lại trạng thái
```
/checkpoint
```

---

## Cấu trúc file hoàn chỉnh

```
.
├── CLAUDE.md
├── AGENTS.md
├── docs/
│   ├── PROJECT_CONTEXT.md
│   ├── RUNBOOK.md
│   ├── TASKS.md
│   ├── BUGS.md
│   ├── DECISIONS.md
│   ├── ARCHITECTURE.md
│   ├── OUTPUT_RULES.md
│   └── SETUP_REPORT.md
├── .claude/
│   ├── settings.json
│   ├── skills/
│   │   ├── project-onboarding/SKILL.md
│   │   ├── requirement-clarify/SKILL.md
│   │   ├── fast-feature/SKILL.md
│   │   ├── fix-bug-loop/SKILL.md
│   │   ├── test-gate/SKILL.md
│   │   ├── code-review/SKILL.md
│   │   ├── ship-check/SKILL.md
│   │   └── docs-update/SKILL.md
│   ├── agents/
│   │   ├── orchestrator.md
│   │   ├── planner.md
│   │   ├── coder.md
│   │   ├── tester.md
│   │   ├── reviewer.md
│   │   └── debugger.md
│   └── commands/
│       ├── init-project.md
│       ├── clarify.md
│       ├── fast-feature.md
│       ├── fix-bug.md
│       ├── loop.md
│       ├── review.md
│       ├── ship.md
│       └── checkpoint.md
├── scripts/
│   ├── check.sh
│   ├── check.ps1
│   ├── dev.sh
│   └── dev.ps1
└── templates/
    ├── FEATURE_SPEC.md
    ├── BUG_REPORT.md
    └── PR_TEMPLATE.md
```
