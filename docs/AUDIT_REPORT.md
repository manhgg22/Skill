# Audit Report — Claude Code Output System

**Ngày audit:** 2026-06-10
**Auditor:** Claude Code
**Scope:** Setup files chỉ — không đụng code business

---

## Overall Status

**PASS với 4 điểm cần fix**

Hệ thống đủ cấu trúc, an toàn để dùng. Các vấn đề tìm thấy không phá vỡ hệ thống nhưng cần sửa để hoạt động đúng trên Windows và tránh conflict với built-in commands.

---

## Missing Files

**Không có file nào bị thiếu.** Tất cả 40 file đúng theo spec:

| Nhóm | Số file | Status |
|------|---------|--------|
| Root (CLAUDE.md, AGENTS.md) | 2 | ✅ |
| docs/ | 8 | ✅ |
| .claude/skills/ | 8 SKILL.md | ✅ |
| .claude/agents/ | 6 | ✅ |
| .claude/commands/ | 8 | ✅ |
| .claude/settings.json | 1 | ✅ |
| scripts/ | 4 | ✅ |
| templates/ | 3 | ✅ |

---

## CLAUDE.md Quality Check

| Tiêu chí | Status | Ghi chú |
|----------|--------|---------|
| Loop bắt buộc | ✅ | `Understand → Clarify → Spec → Plan → Implement → Check → Review → Improve → Ship` (đã sửa) |
| Không over-engineer | ✅ | "Chọn slice nhỏ nhất", "Không over-engineer" |
| Không đổi schema/package/file nếu chưa hỏi | ✅ | Bảng "Giới hạn cứng" rõ ràng |
| Format báo cáo cuối task | ✅ | Template đầy đủ: files, commands, rủi ro, next steps |
| Đọc PROJECT_CONTEXT/RUNBOOK/TASKS trước khi code | ✅ | Mục "Đọc trước khi code" có 5 file |
| Đọc OUTPUT_RULES.md | ✅ | Đã thêm vào mục đọc trước (fix trong audit này) |
| Skill trigger mapping | ✅ | Bảng tình huống → skill rõ ràng |

---

## Skills Quality Check

| Skill | Description rõ | Trigger rõ | Workflow đủ | Safety rules | Status |
|-------|---------------|-----------|-------------|-------------|--------|
| project-onboarding | ✅ | ✅ | ✅ | ✅ | ✅ |
| requirement-clarify | ✅ | ✅ | ✅ | ✅ | ✅ |
| fast-feature | ✅ | ✅ | ✅ | ✅ | ✅ |
| fix-bug-loop | ✅ | ✅ | ✅ | ✅ | ✅ |
| test-gate | ✅ | ✅ | ✅ | ✅ | ✅ |
| code-review | ✅ | ✅ | ✅ | ✅ | ✅ |
| ship-check | ✅ | ✅ | ✅ | ✅ | ✅ |
| docs-update | ✅ | ✅ | ✅ | ✅ | ✅ |

**Thiếu:** Ruby/Gemfile — project-onboarding skill liệt kê `Gemfile → Ruby/Rails` nhưng `check.sh` và `check.ps1` không có xử lý Ruby (`bundle exec rspec`, `rails test`).

---

## Agents Quality Check

| Agent | Role rõ | Không code | Không review | Không sửa ngoài scope | Status |
|-------|---------|-----------|-------------|----------------------|--------|
| orchestrator | ✅ | ✅ | ✅ | ✅ | ✅ |
| planner | ✅ | ✅ N/A | ✅ | ✅ | ✅ |
| coder | ✅ | ✅ N/A | ✅ | ✅ | ✅ |
| tester | ✅ | ✅ | ✅ | ✅ | ✅ |
| reviewer | ✅ | ✅ | ✅ N/A | ✅ | ✅ |
| debugger | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## Weak Points

### 1. 🔴 CRITICAL — `/loop` command conflict với built-in Claude Code

`/loop` là built-in skill của Claude Code với ý nghĩa **hoàn toàn khác**:
- **Built-in:** "Run a prompt on a recurring interval (e.g. /loop 5m /foo)" — cron-style loop
- **Hệ thống này:** "Chia nhỏ goal lớn và thực hiện từng bước" — workflow decomposition

Khi user gõ `/loop build authentication`, Claude có thể hiểu nhầm là muốn chạy "build authentication" theo interval 5 phút.

**Fix:** Đổi tên command từ `loop.md` → `goal-loop.md` và cập nhật tham chiếu trong CLAUDE.md.

---

### 2. 🟡 MEDIUM — `check.sh` dùng `set -e` (đã sửa → `set -u`)

File gốc dùng `set -e` (exit on any error). Vấn đề:
- Nếu bất kỳ lệnh nào trong script thất bại mà không nằm trong `if/while/until`, script thoát ngay mà **không tăng FAIL counter**.
- Kết quả: script báo "0 failed" thay vì số thực, hoặc thoát sớm trước khi in summary.

**Đã fix:** Đổi thành `set -u` — bắt lỗi biến chưa khai báo, không exit trên lỗi lệnh (để counter hoạt động đúng).

---

### 3. 🟡 MEDIUM — `settings.json` thiếu `PowerShell(...)` entries

Project chạy trên Windows. `check.ps1` và `dev.ps1` sẽ không được auto-approve vì settings.json chỉ có `Bash(...)` entries.

Mỗi lần chạy scripts PowerShell, Claude sẽ cần prompt user approve thủ công.

**Fix cần làm thủ công** (blocked bởi auto-classifier khi audit):
```json
"allow": [
  ...existing entries...,
  "PowerShell(Get-ChildItem*)",
  "PowerShell(Get-Content*)",
  "PowerShell(.\\scripts\\check.ps1*)",
  "PowerShell(.\\scripts\\dev.ps1*)"
]
```

---

### 4. 🟡 MEDIUM — `settings.json` cho phép `Bash(cat*)` quá rộng

`Bash(cat*)` cho phép đọc **bất kỳ file nào**: `.env`, `~/.ssh/id_rsa`, files chứa credential. Claude nên dùng `Read` tool thay vì `cat` để đọc files trong hầu hết trường hợp.

**Fix cần làm thủ công:**
```json
// Thay:
"Bash(cat*)"
// Bằng:
"Bash(cat *.md)",
"Bash(cat *.json)",
"Bash(cat *.yaml)",
"Bash(cat *.yml)",
"Bash(cat *.toml)"
```

---

### 5. 🟢 LOW — CLAUDE.md loop thiếu "Spec" và "Improve" step (đã sửa)

Loop gốc: `Understand → Clarify → Plan → Implement → Check → Review → Report`

Thiếu 2 bước so với requirement `Goal → Clarify → Spec → Plan → Task → Code → Test → Review → Improve → Ship`:
- "Spec" (output của Clarify, input của Plan)  
- "Improve" (iterate sau Review trước khi Ship)

**Đã fix:** Loop mới: `Understand → Clarify → Spec → Plan → Implement → Check → Review → Improve → Ship`

---

### 6. 🟢 LOW — `check.sh` Gradle detection có operator precedence risk

Dòng 93:
```bash
command -v gradle >/dev/null 2>&1 || [ -f "./gradlew" ] && run_check "Test (gradle)" "$GRADLE_CMD test" || skip_check "..."
```
Bash parse `&&` và `||` left-to-right, dẫn đến logic không rõ. Nên thêm ngoặc hoặc tách thành if/else.

---

### 7. 🟢 LOW — Ruby/Gemfile thiếu trong check scripts

`project-onboarding` skill nhận biết `Gemfile → Ruby/Rails` nhưng `check.sh` và `check.ps1` không xử lý Ruby (`bundle exec rspec`, `ruby -Itest test/**/*_test.rb`, `rails test`).

---

### 8. ℹ️ INFO — `review` và `code-review` có thể shadow built-in

Built-in Claude Code có sẵn `/review` và `/code-review` skill. Project này tạo cùng tên. Claude Code ưu tiên project skill, nhưng nên biết để không nhầm lẫn khi debug.

---

## Safety Issues

| Issue | Severity | Status |
|-------|----------|--------|
| `check.sh`: `set -e` exit sớm, mask failure count | Medium | ✅ Fixed → `set -u` |
| `settings.json`: `Bash(cat*)` đọc sensitive files | Medium | ⚠️ Cần sửa thủ công |
| `settings.json`: thiếu PowerShell entries (Windows) | Medium | ⚠️ Cần sửa thủ công |
| `settings.json`: không có hook nguy hiểm | ✅ Safe | — |
| Scripts: không có `rm -rf`, `db reset`, `git push` | ✅ Safe | — |
| Commands: `/ship` không commit/push | ✅ Safe | — |
| Agents: tất cả đều có "không sửa code khi chưa được yêu cầu" | ✅ Safe | — |

---

## Commands Checked

| Command | Kết quả |
|---------|---------|
| `git status` | Repo chưa có `.git` — không phải git repo. Scripts check.sh/check.ps1 sẽ bỏ qua `git diff`. |
| `git diff --stat` | N/A (không có git repo) |
| File structure scan | 40 files đúng theo spec |
| settings.json parse | Valid JSON, structure đúng |
| check.sh syntax | Đã sửa `set -e` → `set -u` |
| check.ps1 syntax | OK — logic đúng |

---

## Suggested Fixes

### Fix 1 — Đổi tên `/loop` (tránh conflict với built-in)

```bash
# Rename file
mv .claude/commands/loop.md .claude/commands/goal-loop.md
```

Cập nhật frontmatter trong file:
```yaml
name: goal-loop
description: Chia nhỏ goal lớn và thực hiện từng bước. Dùng: /goal-loop <goal>
```

Cập nhật CLAUDE.md:
```
/goal-loop <goal lớn>  — Chia nhỏ goal, thực hiện từng bước
```

---

### Fix 2 — Thêm PowerShell permissions vào settings.json

Mở `.claude/settings.json`, thêm vào array `"allow"`:
```json
"PowerShell(Get-ChildItem*)",
"PowerShell(Get-Content*)",
"PowerShell(.\\scripts\\check.ps1*)",
"PowerShell(.\\scripts\\dev.ps1*)",
"PowerShell(scripts\\check.ps1*)",
"PowerShell(scripts\\dev.ps1*)"
```

---

### Fix 3 — Thu hẹp `Bash(cat*)` trong settings.json

Thay `"Bash(cat*)"` bằng:
```json
"Bash(cat *.md)",
"Bash(cat *.json)",
"Bash(cat *.yaml)",
"Bash(cat *.yml)",
"Bash(cat *.toml)",
"Bash(cat *.txt)"
```

---

### Fix 4 — Thêm Ruby vào check scripts (optional)

Thêm vào cuối `check.sh` trước phần Makefile fallback:
```bash
# ── Ruby / Rails ──
if [ -f "Gemfile" ]; then
  echo ""
  echo "[Ruby detected]"
  command -v bundle >/dev/null 2>&1 || { skip_check "Test" "bundler not installed"; }
  if grep -q "rspec" Gemfile 2>/dev/null; then
    run_check "Test (rspec)" "bundle exec rspec"
  elif [ -f "Rakefile" ]; then
    run_check "Test (rake)" "bundle exec rake test"
  else
    skip_check "Test" "no test runner detected"
  fi
fi
```

---

## Ready-to-use Commands

Sau khi hoàn tất Fix 1–3:

```
/init-project         — Đọc repo, điền PROJECT_CONTEXT và RUNBOOK
/clarify <yêu cầu>   — Biến yêu cầu mờ thành spec rõ
/fast-feature <feat>  — Implement feature nhỏ nhất chạy được
/fix-bug <lỗi>        — Tìm root cause, fix nhỏ nhất
/goal-loop <goal>     — Chia nhỏ goal, thực hiện từng bước  ← đổi tên từ /loop
/review               — Review git diff hiện tại
/ship                 — Kiểm tra và tổng kết trước commit
/checkpoint           — Ghi lại trạng thái vào TASKS.md
```

---

## Tóm tắt fix theo priority

| # | Fix | Priority | Status |
|---|-----|----------|--------|
| 1 | Đổi `/loop` → `/goal-loop` | 🔴 HIGH | ✅ DONE — 2026-06-10 |
| 2 | Thêm PowerShell entries vào settings.json | 🟡 MED | ✅ DONE — 2026-06-10 |
| 3 | Thu hẹp `Bash(cat*)` | 🟡 MED | ✅ DONE — 2026-06-10 |
| 4 | Thêm Ruby support vào check scripts | 🟢 LOW | OPEN — chỉ cần nếu dùng Ruby |
| 5 | Fix Gradle operator precedence | 🟢 LOW | OPEN — không urgent |

## Audit Fix Log — 2026-06-10

**Fix 1 — `/loop` → `/goal-loop`**
- Tạo `.claude/commands/goal-loop.md` với `name: goal-loop`
- Xóa `.claude/commands/loop.md`
- Sửa `CLAUDE.md`: `/loop` → `/goal-loop`
- Sửa `.claude/agents/orchestrator.md`: description updated
- Sửa `docs/SETUP_REPORT.md`: 2 references updated
- README.md đã dùng `/goal-loop` từ trước — không cần sửa

**Fix 2 — Thêm PowerShell permissions**
- Thêm 6 `PowerShell(...)` entries vào `.claude/settings.json` allow list

**Fix 3 — Thu hẹp `Bash(cat*)`**
- Thay `"Bash(cat*)"` bằng 6 entries giới hạn theo extension cụ thể
