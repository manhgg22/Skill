---
name: test-gate
description: Chạy lint/test/build theo RUNBOOK. Tự phát hiện command nếu RUNBOOK chưa điền. Kích hoạt trước /ship, sau /fast-feature, hoặc khi user muốn kiểm tra code hiện tại.
---

# Test Gate

Mục tiêu: Xác nhận code hiện tại pass tất cả check trước khi ship. Không sửa code.

## Tự phát hiện command

Đọc theo thứ tự:

```
1. docs/RUNBOOK.md → lấy command đã điền
2. Nếu RUNBOOK trống:
   - package.json  → npm test, npm run lint, npm run build
   - composer.json → composer test, php artisan test
   - pyproject.toml/setup.py → pytest, ruff check
   - pom.xml       → mvn test
   - build.gradle  → ./gradlew test
   - *.csproj      → dotnet test
   - Makefile      → make test, make lint
```

## Thứ tự chạy

```
1. Lint (nhanh nhất, fail sớm)
2. Unit tests
3. Build (cuối cùng, chậm nhất)
```

## Rules

- **Không cài package** nếu thiếu dependency — báo lỗi rõ.
- **Không sửa code** nếu test fail — chỉ báo lỗi.
- Nếu command không tồn tại (không có script "test"), ghi chú rõ.

## Output

```
## Test Gate Results

| Check | Command | Result |
|-------|---------|--------|
| Lint  | `npm run lint` | ✅ PASS |
| Test  | `npm test` | ✅ PASS (42 passed) |
| Build | `npm run build` | ✅ PASS |

**Tổng kết:** ✅ Sẵn sàng ship / ❌ Cần fix trước

**Lỗi (nếu có):**
[paste lỗi ngắn]
```

## Nếu không tìm được command

```
⚠️ Không tìm được test/lint/build command.
Cần cập nhật docs/RUNBOOK.md với command thực tế của project.
```
