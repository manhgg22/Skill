---
name: clarify
description: Biến yêu cầu mơ hồ thành spec rõ. Dùng: /clarify <yêu cầu>
argument-hint: "<mô tả yêu cầu>"
---

Yêu cầu cần clarify: $ARGUMENTS

Chạy skill `requirement-clarify`:

1. Phân tích yêu cầu trên.
2. Nếu thiếu thông tin quan trọng → hỏi tối đa 3 câu.
3. Nếu đủ thông tin → xuất spec ngay.
4. Output: User Stories, Acceptance Criteria, Out of Scope, Estimate.

Sau khi có spec, hỏi: "Confirm spec này và chạy /fast-feature không?"
