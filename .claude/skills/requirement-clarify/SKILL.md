---
name: requirement-clarify
description: Biến yêu cầu mơ hồ thành spec rõ ràng. Kích hoạt khi user paste yêu cầu mới, dùng /clarify, hoặc khi Claude cần thêm thông tin trước khi code.
---

# Requirement Clarify

Mục tiêu: Biến yêu cầu vague thành spec có thể implement được mà không cần hỏi đi hỏi lại.

## Khi nào hỏi, khi nào tự giả định

**Hỏi lại khi:**
- Không rõ output mong muốn (ví dụ: "làm nhanh hơn" — nhanh hơn bao nhiêu?)
- Có thể gây breaking change (đổi schema, xóa data, thay đổi API)
- Scope quá lớn, không biết nên bắt đầu từ đâu

**Tự giả định và ghi rõ khi:**
- Yêu cầu nhỏ, rõ ràng về behavior
- Có thể làm phiên bản đơn giản nhất trước
- Giả định không gây hại nếu sai

## Tối đa 3 câu hỏi — theo thứ tự

1. **Câu về output/behavior:** "Kết quả mong muốn là gì?" / "User sẽ thấy/làm gì?"
2. **Câu về ràng buộc:** "Có gì không được làm?" / "Có dependency nào cần biết?"
3. **Câu về ưu tiên:** "Nếu chỉ làm 1 thứ trước, đó là gì?"

## Output của skill này

```markdown
## Spec: [Tên tính năng]

**Mô tả:** [1-2 câu]

**User Stories:**
- Là [user], tôi muốn [làm gì] để [lý do]

**Acceptance Criteria:**
- [ ] [Tiêu chí 1 — có thể test được]
- [ ] [Tiêu chí 2]

**Out of Scope:**
- Không làm: [...]

**Giả định:**
- [Giả định đã dùng nếu không hỏi user]

**Estimate:** S / M / L / XL
```

Sau khi viết spec xong, đề xuất chạy `/fast-feature` nếu task là S/M.
