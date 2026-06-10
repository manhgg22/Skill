# RUNBOOK.md

> Hướng dẫn chạy, build, test, lint project. Phải được cập nhật khi thêm script mới.
> Được điền bởi `/init-project`, cập nhật thủ công khi cần.

## Khởi động dev server

```bash
# Điền command thực tế sau khi chạy /init-project
# Ví dụ: npm run dev | pnpm dev | php artisan serve | python manage.py runserver
```

## Build production

```bash
# Ví dụ: npm run build | pnpm build | mvn package | dotnet publish
```

## Chạy test

```bash
# Ví dụ: npm test | pytest | php artisan test | dotnet test
```

## Lint / Format

```bash
# Ví dụ: npm run lint | ruff check . | ./gradlew lint
```

## Database

```bash
# Migration: (điền nếu có)
# Seed:      (điền nếu có)
# Reset:     (điền nếu có — KHÔNG chạy trên production)
```

## Scripts tiện ích

```bash
# scripts/check.ps1 hoặc scripts/check.sh — tự phát hiện và chạy lint/test/build
# scripts/dev.ps1 hoặc scripts/dev.sh     — khởi động dev server
```

## Lưu ý

- Không chạy `git push` nếu chưa được user yêu cầu.
- Không chạy migration production nếu chưa được xác nhận.
- Nếu thiếu `.env`, copy từ `.env.example` và điền giá trị cần thiết.
