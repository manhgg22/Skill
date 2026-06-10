---
name: fix-bug-loop
description: Tìm root cause, fix nhỏ nhất, chạy lại check. Kích hoạt khi user báo lỗi, paste stack trace, dùng /fix-bug, hoặc khi test FAIL.
---

# Fix Bug Loop

Mục tiêu: Fix đúng bug, không fix thêm gì khác, không tạo bug mới.

## Loop

```
Đọc lỗi → Reproduce (nếu có thể) → Khoanh vùng → Fix nhỏ nhất → Check → Ghi BUGS.md
```

## Bước 1 — Đọc lỗi

Thu thập:
- Error message đầy đủ
- Stack trace (file:line quan trọng nhất)
- Điều kiện xảy ra (input gì, state gì, browser/OS gì)

Không đoán mò trước khi đọc kỹ.

## Bước 2 — Khoanh vùng

Câu hỏi cần trả lời:
- Lỗi xảy ra ở layer nào? (UI / API / DB / infra)
- Lỗi là data sai, logic sai, hay type sai?
- Lỗi có tái hiện được không? (100% / flaky / chỉ production)

Đọc ít nhất 2 file liên quan trước khi viết bất kỳ dòng fix nào.

## Bước 3 — Fix nhỏ nhất

- Thay đổi ít dòng nhất có thể.
- Không refactor xung quanh.
- Không đổi API / interface nếu không cần thiết.
- Nếu fix cần đổi schema → dừng lại, hỏi user.

## Bước 4 — Chạy check

```bash
# Windows
scripts/check.ps1

# Unix
bash scripts/check.sh
```

Nếu FAIL → đọc lỗi mới → lặp lại từ bước 2 (tối đa 3 vòng).
Nếu sau 3 vòng vẫn FAIL → dừng, báo cáo tình trạng, đề xuất hướng tiếp theo.

## Bước 5 — Ghi BUGS.md

```markdown
## [Ngày] — [Tiêu đề bug ngắn]
**Root cause:** [1 câu]
**Fix:** [File đã sửa, thay đổi gì]
**Test:** [Command đã chạy, kết quả]
```

## Output

```
## Kết quả fix-bug

**Bug:** [Mô tả]
**Root cause:** [1 câu]
**Files đã sửa:** [list]
**Commands:** `<command>` → ✅ PASS / ❌ FAIL
**Ghi chú rủi ro:** [nếu có]
```
