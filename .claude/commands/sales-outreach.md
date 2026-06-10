---
name: sales-outreach
description: Viết outreach message cá nhân hóa cho một lead cụ thể. Dùng: /sales-outreach
argument-hint: "<tên công ty hoặc lead>"
---

# /sales-outreach

Viết message cá nhân hóa cho lead đã có trong `docs/SALES_LEADS.md` hoặc từ thông tin user cung cấp.

## Workflow

1. Đọc thông tin lead (company, trigger, decision maker nếu có)
2. Gọi `outreach-writing-agent` viết:
   - LinkedIn/Facebook message (≤ 120 từ)
   - Email cold outreach nếu có email public
   - Follow-up D+3
   - Follow-up D+7
3. Gọi `sales-review-agent` kiểm tra trước khi xuất
4. Lưu vào `docs/SALES_MESSAGES.md`
5. Hỏi user: "Duyệt để gửi chưa?"

**Không gửi. Chỉ draft.**
