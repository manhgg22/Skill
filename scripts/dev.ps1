# scripts/dev.ps1 — Khởi động dev server (Windows PowerShell)
# Tự phát hiện command. Không cài package.

Write-Host "==============================" -ForegroundColor Cyan
Write-Host "  Dev Server" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

# ── Node.js ──
if (Test-Path "package.json") {
    $pkgMgr = "npm"
    if (Test-Path "pnpm-lock.yaml") { $pkgMgr = "pnpm" }
    if (Test-Path "yarn.lock")      { $pkgMgr = "yarn" }

    if (-not (Test-Path "node_modules")) {
        Write-Host "⚠️  node_modules not found. Run '$pkgMgr install' first." -ForegroundColor Yellow
        exit 1
    }

    $pkg = Get-Content "package.json" -Raw | ConvertFrom-Json
    $scripts = $pkg.scripts

    if ($scripts.dev) {
        Write-Host "▶ Running: $pkgMgr run dev"
        & $pkgMgr run dev
        exit $LASTEXITCODE
    } elseif ($scripts.start) {
        Write-Host "▶ Running: $pkgMgr start"
        & $pkgMgr start
        exit $LASTEXITCODE
    } else {
        Write-Host "⚠️  No 'dev' or 'start' script found in package.json" -ForegroundColor Yellow
        Write-Host "   Update docs/RUNBOOK.md with the correct dev command."
        exit 1
    }
}

# ── Python / Django ──
if (Test-Path "manage.py") {
    Write-Host "▶ Running: python manage.py runserver"
    python manage.py runserver
    exit $LASTEXITCODE
}

# ── PHP / Laravel ──
if (Test-Path "artisan") {
    Write-Host "▶ Running: php artisan serve"
    php artisan serve
    exit $LASTEXITCODE
}

# ── Python app.py / main.py ──
if (Test-Path "app.py") {
    Write-Host "▶ Running: python app.py"
    python app.py
    exit $LASTEXITCODE
}

# ── Không xác định được ──
Write-Host "⚠️  Could not detect dev server command." -ForegroundColor Yellow
Write-Host "   Please update docs/RUNBOOK.md with:"
Write-Host "   'Dev server: <your command here>'"
exit 1
