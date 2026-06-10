---
name: followup-planning
description: Lập kế hoạch follow-up sequence sau khi đã gửi outreach đầu tiên.
triggers:
  - "follow up"
  - "follow-up"
  - "nhắc lại"
  - "chưa reply"
  - "lịch follow-up"
---

# Follow-up Planning Skill

## Sequence mặc định

| Ngày | Action | Kênh | Ghi chú |
|------|--------|------|---------|
| D+0 | Gửi message đầu (đã duyệt) | LinkedIn / Email | Lưu ngày gửi |
| D+3 | Follow-up 1 | LinkedIn | Ngắn, thêm value nhỏ |
| D+7 | Follow-up 2 (cuối) | Email | Giữ cửa mở, không chase nữa |
| D+30 | Nurture (optional) | LinkedIn | Share content liên quan |

## Rules

- Tối đa 2 follow-up sau message đầu
- Không chase quá 3 lần tổng cộng
- Nếu reply negative hoặc "không quan tâm" → STOP ngay, không follow-up thêm
- Nếu không reply sau D+7 → chuyển sang Nurture (không direct pitch)

## Follow-up D+3 template structure
```
[Reference tin nhắn trước — không giả sử họ đọc rồi]
[Thêm 1 điểm giá trị mới — insight, case study liên quan]
[CTA nhẹ]
```

## Follow-up D+7 template structure
```
[Lần cuối, không pressure]
[Để cửa mở: "Nếu timing chưa phù hợp, hoàn toàn ổn — mình sẵn sàng khi anh/chị cần"]
[Không CTA mạnh]
```

## KHÔNG làm

- Không follow-up quá 2 lần sau message đầu
- Không follow-up nếu họ đã nói không
- Không escalate sang gọi điện nếu chưa được phép
