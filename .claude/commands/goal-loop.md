---
name: goal-loop
description: Chia nhỏ goal lớn và thực hiện từng bước. Dùng: /goal-loop <goal lớn>
argument-hint: "<goal lớn cần đạt được>"
---

Goal: $ARGUMENTS

Gọi Orchestrator agent để điều phối:

1. Gọi Planner → breakdown goal thành danh sách task nhỏ.
2. Hiển thị danh sách task, hỏi user confirm hoặc điều chỉnh.
3. Sau khi confirm, bắt đầu task nhỏ nhất:
   - Chạy `/fast-feature` hoặc `/fix-bug` tùy loại task.
4. Sau mỗi task hoàn thành:
   - Cập nhật `docs/TASKS.md`.
   - Hỏi user: "Tiếp tục task tiếp theo không? [Y/n]"
5. Lặp lại đến khi hết task hoặc user dừng.

Sau mỗi vòng, báo tiến độ:
```
✅ Done: [N tasks]
🔄 Next: [task tiếp theo]
📋 Backlog: [N tasks còn lại]
```
