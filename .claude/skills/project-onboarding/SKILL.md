---
name: project-onboarding
description: Đọc repo, xác định stack, điền PROJECT_CONTEXT.md và RUNBOOK.md. Kích hoạt khi user chạy /init-project, khi docs/PROJECT_CONTEXT.md còn trống, hoặc khi Claude không nhận ra stack của project.
---

# Project Onboarding

Mục tiêu: Hiểu project trong vòng 1 lần đọc, không hỏi user những gì có thể tự tìm được.

## Bước 1 — Xác định stack

Đọc theo thứ tự ưu tiên:

```
package.json          → Node.js / npm / pnpm / yarn
composer.json         → PHP / Laravel / Symfony
pyproject.toml        → Python / Poetry / FastAPI / Django
requirements.txt      → Python / pip
pom.xml               → Java / Maven / Spring
build.gradle          → Java / Kotlin / Gradle
Cargo.toml            → Rust
go.mod                → Go
*.csproj / *.sln      → .NET / C#
Gemfile               → Ruby / Rails
```

Sau khi xác định, ghi vào `docs/PROJECT_CONTEXT.md`:
- Runtime + version
- Framework chính
- Package manager
- Database (tìm trong config files, .env.example, docker-compose.yml)

## Bước 2 — Xác định cấu trúc thư mục quan trọng

Liệt kê tối đa 15 thư mục/file quan trọng nhất:
- Entry point chính (main, index, app, server)
- Config files
- Routes / Controllers
- Models / Schema / Entities
- Tests
- Static assets / Views

Ghi vào `docs/PROJECT_CONTEXT.md` phần "Cấu trúc thư mục".

## Bước 3 — Xác định commands

Tìm trong:
- `package.json` → scripts: dev, start, build, test, lint
- `Makefile` → targets
- `composer.json` → scripts
- `pyproject.toml` → tool.taskipy / tool.poe

Điền vào `docs/RUNBOOK.md`:
- Dev server command
- Build command
- Test command
- Lint command

Nếu không tìm được, ghi "_chưa xác định, cần user điền_".

## Bước 4 — Xác định architecture tổng quát

Đọc nhanh README nếu có. Vẽ sơ đồ text đơn giản của các thành phần chính.
Điền vào `docs/ARCHITECTURE.md`.

## Output

Sau khi hoàn thành, báo cáo ngắn:
```
✅ Stack: [tên stack]
✅ Package manager: [tên]
✅ Dev command: [command]
✅ Test command: [command]
✅ Đã điền: docs/PROJECT_CONTEXT.md, docs/RUNBOOK.md, docs/ARCHITECTURE.md
⚠️ Cần bổ sung: [danh sách nếu có]
```
