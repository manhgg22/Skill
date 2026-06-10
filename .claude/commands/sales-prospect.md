---
name: sales-prospect
description: Chạy Sales Prospecting & Outreach Workflow đầy đủ 6 rounds — Define ICP → Research → Score → Write Outreach → Review → Output. Dùng: /sales-prospect
argument-hint: "<mô tả ICP hoặc để trống — Claude sẽ hỏi>"
---

# /sales-prospect

Khi user dùng lệnh này, gọi `sales-orchestrator` agent để chạy toàn bộ workflow 6 rounds:

1. **ROUND 1 — DEFINE ICP:** Xác định hoặc hỏi ICP (tối đa 3 câu nếu thiếu)
2. **ROUND 2 — RESEARCH LEADS:** Lead Research Agent tìm leads từ nguồn public
3. **ROUND 3 — SCORE:** Lead Scoring Agent chấm điểm A/B/C/Reject
4. **ROUND 4 — WRITE OUTREACH:** Outreach Writing Agent soạn message draft
5. **ROUND 5 — REVIEW:** Sales Review Agent kiểm tra compliance + quality
6. **ROUND 6 — OUTPUT:** Xuất lead list + message drafts + follow-up plan

**Không tự gửi tin.** Mọi message phải qua bước user duyệt trước.

## Ví dụ

```
/sales-prospect
```
→ Claude hỏi ICP rồi chạy workflow

```
/sales-prospect tìm brand và agency cần làm TVC hoặc branded content, khu vực TP.HCM, quy mô 50-500 người
```
→ Chạy luôn với ICP đã cung cấp
