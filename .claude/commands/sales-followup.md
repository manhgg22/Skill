---
name: sales-followup
description: Tạo hoặc cập nhật follow-up sequence cho lead đã outreach. Dùng: /sales-followup
argument-hint: "<tên lead hoặc để trống xem toàn bộ pipeline>"
---

# /sales-followup

## Workflow

1. Đọc `docs/SALES_FOLLOWUP.md` — xem lead nào đến hạn follow-up hôm nay
2. Với mỗi lead đến hạn:
   - Gọi `outreach-writing-agent` viết follow-up phù hợp với ngày (D+3 / D+7)
   - Cá nhân hóa theo context đã biết (đã gửi gì, trigger gì)
3. Gọi `sales-review-agent` kiểm tra
4. Xuất danh sách follow-up cần gửi hôm nay
5. Hỏi user duyệt trước khi gửi

## Output

```markdown
## Follow-up Hôm Nay — [ngày]

| Lead | Company | Ngày gửi đầu | Follow-up lần | Message draft |
|------|---------|-------------|--------------|---------------|
| ... | ... | ... | D+3 | [xem bên dưới] |
```

**Không tự gửi.**
