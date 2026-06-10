# CLAUDE.md — Claude Code Output System

## Loop bắt buộc

Với **mọi** yêu cầu, Claude phải đi theo vòng này:

```
Understand → Clarify (nếu cần) → Spec → Plan → Implement → Check → Review → Improve → Ship
```

Không bỏ qua bước nào. Không tự ý gộp bước.

---

## Đọc trước khi code

Trước khi viết bất kỳ dòng code nào, đọc các file sau (nếu tồn tại):

1. `docs/PROJECT_CONTEXT.md` — stack, cấu trúc, quyết định kỹ thuật
2. `docs/RUNBOOK.md` — command chạy app, test, build, lint
3. `docs/TASKS.md` — task đang làm, backlog, done
4. `docs/ARCHITECTURE.md` — sơ đồ hệ thống, luồng dữ liệu
5. `docs/OUTPUT_RULES.md` — format báo cáo và quy tắc output

Nếu file chưa có, chạy `/init-project` trước.

---

## Quy tắc làm việc

### Khi yêu cầu mơ hồ
- Hỏi tối đa **3 câu** quan trọng nhất.
- Ưu tiên câu hỏi về: scope, output mong muốn, ràng buộc kỹ thuật.
- Nếu task nhỏ và có thể tự giả định: chọn phương án đơn giản nhất, ghi rõ giả định, tiếp tục.

### Khi implement
- Chọn **slice nhỏ nhất** có thể chạy được trước.
- Không làm tính năng phụ khi chưa được yêu cầu.
- Implement ít file nhất có thể.
- Không over-engineer.

### Giới hạn cứng — KHÔNG làm nếu chưa hỏi user

| Hành động | Lý do |
|-----------|-------|
| Đổi database schema | Rủi ro mất dữ liệu |
| Thêm package/dependency | Có thể xung đột, bloat |
| Xóa hoặc rename file lớn | Không thể khôi phục dễ |
| Sửa code ngoài scope yêu cầu | Scope creep |
| `git push`, `git reset --hard` | Không thể hoàn tác |
| `rm -rf`, `del /s /q` | Xóa không thể khôi phục |
| Clone/cài repo ngoài | Bảo mật, kiểm soát |
| Chạy migration production | Rủi ro downtime |

---

## Báo cáo sau mỗi task

Sau khi hoàn thành, **bắt buộc** báo:

```
## Kết quả

**Files đã sửa/tạo:**
- path/to/file.ts — [mô tả ngắn]

**Commands đã chạy:**
- `npm test` → PASS / FAIL

**Giả định đã dùng (nếu có):**
- ...

**Rủi ro:**
- ...

**Bước tiếp theo đề xuất:**
- [ ] ...
```

---

## Skills tự động

Claude sẽ tự kích hoạt skill phù hợp dựa trên ngữ cảnh:

| Tình huống | Skill được dùng |
|-----------|----------------|
| User paste yêu cầu mới | `requirement-clarify` → `fast-feature` |
| User báo bug/lỗi | `fix-bug-loop` |
| Trước khi merge/ship | `test-gate` → `code-review` → `ship-check` |
| Project mới/không rõ stack | `project-onboarding` |
| Cần cập nhật docs | `docs-update` |

---

## Commands có sẵn

```
/init-project         — Đọc repo, điền PROJECT_CONTEXT và RUNBOOK
/clarify <yêu cầu>   — Biến yêu cầu mờ thành spec rõ
/fast-feature <feat>  — Implement feature nhỏ nhất chạy được
/fix-bug <mô tả lỗi> — Tìm root cause, fix nhỏ nhất
/goal-loop <goal lớn> — Chia nhỏ goal, thực hiện từng bước
/review               — Review git diff hiện tại
/ship                 — Tổng kết output, check trước khi commit
/checkpoint           — Ghi lại trạng thái hiện tại vào TASKS.md
```

---

## Nguyên tắc chất lượng code

- Không viết comment giải thích code làm gì (tên hàm đã nói lên điều đó).
- Chỉ comment khi lý do không hiển nhiên (invariant ẩn, workaround bug cụ thể).
- Không thêm error handling cho tình huống không thể xảy ra.
- Không thêm abstraction khi chưa cần (3 chỗ tương tự không phải lý do đủ).
- Test golden path và edge case quan trọng — không test implementation detail.

---

## Ưu tiên khi có conflict

```
Chạy được > Đúng > Đẹp > Nhanh > Đầy đủ tính năng
```

---

## Sales Prospecting Safety Rules

Áp dụng khi dùng `/sales-prospect`, `/sales-outreach`, `/sales-followup`.

### KHÔNG BAO GIỜ
- Tự động gửi tin nhắn khi chưa có xác nhận của user
- Bịa tên người, chức vụ, email, số điện thoại, ngân sách
- Scrape website yêu cầu đăng nhập hoặc captcha
- Thu thập thông tin từ data breach hoặc private source
- Dùng thông tin không có source URL công khai
- Giả danh người khác hoặc giả vờ quen biết
- Gửi cùng một message copy-paste cho nhiều người
- Hứa kết quả cụ thể không chắc chắn ("cam kết tăng doanh thu X%")

### BẮT BUỘC
- Mọi lead phải có source URL
- Thông tin không tìm được → ghi `UNKNOWN`
- Citation không tìm thấy → ghi `[REF]` hoặc bỏ qua
- Mọi message draft phải chờ user duyệt trước khi gửi
- Tối đa 2 follow-up sau message đầu
- Nếu lead nói "không quan tâm" → STOP hoàn toàn
