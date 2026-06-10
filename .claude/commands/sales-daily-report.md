---
name: sales-daily-report
description: Tổng kết pipeline sales hôm nay — leads mới, messages đã draft, follow-up đến hạn, cần duyệt. Dùng: /sales-daily-report
---

# /sales-daily-report

Đọc toàn bộ docs sales và xuất báo cáo ngày.

## Workflow

1. Đọc `docs/SALES_LEADS.md` — đếm leads theo tier A/B/C
2. Đọc `docs/SALES_MESSAGES.md` — messages đã draft chưa gửi
3. Đọc `docs/SALES_FOLLOWUP.md` — follow-up đến hạn hôm nay
4. Xuất báo cáo theo template `templates/SALES_REPORT_TEMPLATE.md`
5. Lưu vào `docs/SALES_REPORT.md`

## Output format

```markdown
## Daily Sales Report — [ngày]

### Pipeline
- Tổng leads: X (A: X | B: X | C: X)
- Leads mới hôm nay: X
- Messages draft chờ duyệt: X
- Follow-up đến hạn: X

### Cần làm hôm nay
- [ ] Duyệt X message drafts
- [ ] Gửi X follow-ups đã duyệt
- [ ] Research thêm X leads mới

### Rủi ro / Thiếu dữ liệu
- ...
```
