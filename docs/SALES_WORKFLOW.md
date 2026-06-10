# SALES_WORKFLOW.md — Sales Prospecting & Outreach Workflow

**Version:** 1.0 | **Ngày tạo:** 2026-06-10

---

## Tổng quan

Workflow 6 rounds giúp tìm, đánh giá và soạn thảo outreach cho leads B2B — đặc biệt cho dịch vụ production house / video marketing / branded content.

```
ROUND 1 — DEFINE ICP
    ↓
ROUND 2 — RESEARCH LEADS
    ↓
ROUND 3 — SCORE (A/B/C/Reject)
    ↓
ROUND 4 — WRITE OUTREACH (A/B only)
    ↓
ROUND 5 — REVIEW (compliance + quality)
    ↓  ↘
  PASS  LOOP → fix → review lại
    ↓
ROUND 6 — OUTPUT → user duyệt → gửi
```

## Cách chạy

```
/sales-prospect
```

Hoặc với ICP đã có:
```
/sales-prospect tìm brand và agency cần TVC, khu vực TP.HCM
```

## Commands có sẵn

| Command | Dùng khi |
|---------|---------|
| `/sales-prospect` | Chạy full workflow 6 rounds |
| `/sales-outreach` | Viết message cho 1 lead cụ thể |
| `/sales-followup` | Xem và viết follow-up đến hạn |
| `/sales-daily-report` | Tổng kết pipeline hôm nay |

## Agents trong workflow

| Agent | Round | Vai trò |
|-------|-------|---------|
| sales-orchestrator | All | Điều phối, exit condition |
| lead-research-agent | 2 | Tìm leads từ public sources |
| trigger-detection-agent | 2 | Phát hiện buying signals |
| lead-scoring-agent | 3 | Chấm điểm A/B/C/Reject |
| outreach-writing-agent | 4 | Soạn message cá nhân hóa |
| sales-review-agent | 5 | Compliance + quality gate |

## Safety Rules tóm tắt

- Không tự gửi — luôn chờ user duyệt
- Không bịa data — ghi UNKNOWN nếu không tìm thấy
- Không scrape private — chỉ public sources
- Không spam — mỗi message phải cá nhân hóa
