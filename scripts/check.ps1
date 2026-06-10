# scripts/check.ps1 — Tự phát hiện và chạy lint/test/build (Windows PowerShell)
# Không cài package. Báo rõ nếu thiếu dependency.

$pass = 0
$fail = 0
$skip = 0

function Run-Check {
    param([string]$Label, [string]$Cmd)
    Write-Host "▶ $Label`: $Cmd"
    try {
        Invoke-Expression $Cmd
        if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null) {
            Write-Host "  ✅ PASS" -ForegroundColor Green
            $script:pass++
        } else {
            Write-Host "  ❌ FAIL (exit $LASTEXITCODE)" -ForegroundColor Red
            $script:fail++
        }
    } catch {
        Write-Host "  ❌ FAIL: $_" -ForegroundColor Red
        $script:fail++
    }
}

function Skip-Check {
    param([string]$Label, [string]$Reason)
    Write-Host "⏭  $Label`: SKIPPED ($Reason)" -ForegroundColor Yellow
    $script:skip++
}

Write-Host "==============================" -ForegroundColor Cyan
Write-Host "  Check Gate" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

# ── Node.js (package.json) ──
if (Test-Path "package.json") {
    Write-Host "`n[Node.js detected]"
    $pkgMgr = "npm"
    if (Test-Path "pnpm-lock.yaml") { $pkgMgr = "pnpm" }
    if (Test-Path "yarn.lock")      { $pkgMgr = "yarn" }
    Write-Host "  Package manager: $pkgMgr"

    if (-not (Test-Path "node_modules")) {
        Write-Host "  ⚠️  node_modules not found. Run '$pkgMgr install' first." -ForegroundColor Yellow
        $fail++
    } else {
        $pkg = Get-Content "package.json" -Raw | ConvertFrom-Json
        $scripts = $pkg.scripts

        if ($scripts.lint)       { Run-Check "Lint"  "$pkgMgr run lint" }
        else                     { Skip-Check "Lint"  "no lint script" }

        $tcScript = if ($scripts.'type-check') { "$pkgMgr run type-check" }
                    elseif ($scripts.typecheck) { "$pkgMgr run typecheck" }
                    else { $null }
        if ($tcScript)           { Run-Check "Type check" $tcScript }
        else                     { Skip-Check "Type check" "no typecheck script" }

        if ($scripts.test)       { Run-Check "Test"  "$pkgMgr test" }
        else                     { Skip-Check "Test"  "no test script" }

        if ($scripts.build)      { Run-Check "Build" "$pkgMgr run build" }
        else                     { Skip-Check "Build" "no build script" }
    }
}

# ── Python ──
if ((Test-Path "pyproject.toml") -or (Test-Path "setup.py") -or (Test-Path "requirements.txt")) {
    Write-Host "`n[Python detected]"
    if (Get-Command ruff -ErrorAction SilentlyContinue)   { Run-Check "Lint (ruff)"   "ruff check ." }
    else                                                   { Skip-Check "Lint" "ruff not installed" }
    if (Get-Command mypy -ErrorAction SilentlyContinue)   { Run-Check "Type check"    "mypy ." }
    else                                                   { Skip-Check "Type check" "mypy not installed" }
    if (Get-Command pytest -ErrorAction SilentlyContinue) { Run-Check "Test (pytest)" "pytest" }
    else                                                   { Skip-Check "Test" "pytest not installed — run: pip install pytest" }
}

# ── PHP / Laravel ──
if (Test-Path "composer.json") {
    Write-Host "`n[PHP/Composer detected]"
    if (Get-Command php -ErrorAction SilentlyContinue) {
        if (Test-Path "artisan") { Run-Check "Test (artisan)" "php artisan test" }
        else                     { Skip-Check "Test" "no artisan found" }
    } else {
        Write-Host "  ⚠️  PHP not found in PATH" -ForegroundColor Yellow
        $fail++
    }
}

# ── Java / Maven ──
if (Test-Path "pom.xml") {
    Write-Host "`n[Java/Maven detected]"
    if (Get-Command mvn -ErrorAction SilentlyContinue) { Run-Check "Test (mvn)" "mvn test -q" }
    else                                                { Skip-Check "Test" "mvn not installed" }
}

# ── Java / Gradle ──
if ((Test-Path "build.gradle") -or (Test-Path "build.gradle.kts")) {
    Write-Host "`n[Gradle detected]"
    $gradleCmd = if (Test-Path "gradlew.bat") { ".\gradlew.bat" } elseif (Get-Command gradle -ErrorAction SilentlyContinue) { "gradle" } else { $null }
    if ($gradleCmd) { Run-Check "Test (gradle)" "$gradleCmd test" }
    else            { Skip-Check "Test" "gradle not found" }
}

# ── .NET ──
$hasCsproj = (Get-ChildItem -Filter "*.csproj" -ErrorAction SilentlyContinue | Select-Object -First 1) -or (Get-ChildItem -Filter "*.sln" -ErrorAction SilentlyContinue | Select-Object -First 1)
if ($hasCsproj) {
    Write-Host "`n[.NET detected]"
    if (Get-Command dotnet -ErrorAction SilentlyContinue) {
        Run-Check "Build" "dotnet build -q"
        Run-Check "Test"  "dotnet test --no-build -q"
    } else {
        Skip-Check "Test" "dotnet not installed"
    }
}

# ── Go ──
if (Test-Path "go.mod") {
    Write-Host "`n[Go detected]"
    if (Get-Command go -ErrorAction SilentlyContinue) { Run-Check "Test" "go test ./..." }
    else                                               { Skip-Check "Test" "go not installed" }
}

# ── Rust ──
if (Test-Path "Cargo.toml") {
    Write-Host "`n[Rust detected]"
    if (Get-Command cargo -ErrorAction SilentlyContinue) { Run-Check "Test" "cargo test" }
    else                                                  { Skip-Check "Test" "cargo not installed" }
}

# ── Kết quả ──
Write-Host "`n==============================" -ForegroundColor Cyan
Write-Host "  Results: ✅ $pass  ❌ $fail  ⏭  $skip" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

if ($fail -gt 0) { exit 1 }
