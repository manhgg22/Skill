# OUTPUT_RULES.md

> Quy tắc về format output của Claude trong project này.

## Báo cáo sau task

Mọi task đều kết thúc bằng report theo format:

```markdown
## Kết quả

**Files đã sửa/tạo:**
- `path/to/file` — mô tả thay đổi

**Commands đã chạy:**
- `<command>` → ✅ PASS / ❌ FAIL: <lỗi ngắn>

**Giả định đã dùng (nếu có):**
- ...

**Rủi ro:**
- ...

**Bước tiếp theo đề xuất:**
- [ ] ...
```

## Khi hỏi lại user

- Tối đa 3 câu hỏi.
- Đánh số từng câu.
- Hỏi theo thứ tự quan trọng giảm dần.
- Nếu có thể giả định, ghi rõ giả định và tiếp tục.

## Khi plan

- Dùng bullet list ngắn.
- Không viết essay.
- Format: `[ ] Step N — mô tả`

## Khi review code

- Chia 3 nhóm: **Must fix** / **Should fix** / **Nice to have**
- Mỗi issue: file:line — mô tả — tại sao quan trọng

## Không làm

- Không viết summary dài ở cuối mỗi response nếu user không hỏi.
- Không lặp lại những gì đã làm ở đầu và cuối.
- Không dùng heading lớn cho câu trả lời đơn giản.
- Không emoji trừ khi user yêu cầu.
