---
name: sales-compliance
description: Kiểm tra toàn bộ lead data và message drafts theo compliance rules — không spam, không bịa, không private data.
triggers:
  - "kiểm tra compliance"
  - "spam check"
  - "có vi phạm không"
  - "review trước khi gửi"
---

# Sales Compliance Skill

## Hard Rules (vi phạm → remove/reject ngay)

| Rule | Mô tả |
|------|-------|
| Không spam | Không gửi cùng 1 message cho nhiều người |
| Không tự gửi | Phải có user duyệt trước khi gửi |
| Không scrape trái phép | Chỉ dùng thông tin public |
| Không dữ liệu nhạy cảm | Không thu thập private info |
| Không dùng non-public info | Chỉ info có source URL |
| Không bịa | Tên, chức vụ, email, số phone, ngân sách phải có source |
| Không giả danh | Không giả vờ là ai khác |
| Không hứa kết quả | Không cam kết số liệu không chắc |

## Checklist compliance per lead

- [ ] Source URL tồn tại và accessible?
- [ ] Không có field nào bịa (ghi UNKNOWN nếu không biết)?
- [ ] Thông tin không lấy từ private source?

## Checklist compliance per message

- [ ] Cá nhân hóa theo trigger thật, có evidence?
- [ ] Không copy-paste từ lead khác?
- [ ] Không có spam language?
- [ ] Không claim kết quả không chắc?
- [ ] CTA nhẹ nhàng, không pressure?
- [ ] Người gửi được xác định rõ (không anonymous)?

## Khi phát hiện vi phạm

| Vi phạm | Hành động |
|---------|-----------|
| Data bịa | Remove lead khỏi list + báo cáo field cụ thể |
| Message copy-paste | Yêu cầu viết lại, cá nhân hóa |
| Spam language | Flag + đề xuất viết lại |
| Source thiếu | Remove lead hoặc mark `UNVERIFIED` |
