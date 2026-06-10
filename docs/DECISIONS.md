# DECISIONS.md

> Ghi lại các quyết định kỹ thuật quan trọng. Giúp tránh tranh luận lại cùng một vấn đề.

## Template

```
## [Ngày] — [Tiêu đề quyết định]
**Bối cảnh:** [Vấn đề cần giải quyết]
**Lựa chọn đã cân nhắc:** [Option A, Option B, ...]
**Quyết định:** [Chọn gì]
**Lý do:** [Tại sao]
**Hệ quả:** [Tradeoff, ảnh hưởng]
```

---

## 2026-06-10 — Dùng Claude Code Output System

**Bối cảnh:** Cần hệ thống giúp Claude hiểu project và làm việc theo vòng lặp rõ ràng.

**Lựa chọn đã cân nhắc:**
- Viết CLAUDE.md đơn giản
- Dùng hệ thống đầy đủ với skills/agents/commands

**Quyết định:** Dùng hệ thống đầy đủ.

**Lý do:** Cần dùng cho nhiều repo, cần tái sử dụng.

**Hệ quả:** Cần chạy `/init-project` cho mỗi repo mới để điền PROJECT_CONTEXT và RUNBOOK.
