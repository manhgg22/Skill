#!/usr/bin/env bash
# scripts/check.sh — Tự phát hiện và chạy lint/test/build
# Không cài package. Báo rõ nếu thiếu dependency.

set -u

PASS=0
FAIL=0
SKIP=0

run_check() {
  local label="$1"
  local cmd="$2"
  echo "▶ $label: $cmd"
  if eval "$cmd"; then
    echo "  ✅ PASS"
    PASS=$((PASS + 1))
  else
    echo "  ❌ FAIL"
    FAIL=$((FAIL + 1))
  fi
}

skip_check() {
  local label="$1"
  local reason="$2"
  echo "⏭  $label: SKIPPED ($reason)"
  SKIP=$((SKIP + 1))
}

echo "=============================="
echo "  Check Gate"
echo "=============================="

# ── Node.js (package.json) ──
if [ -f "package.json" ]; then
  echo ""
  echo "[Node.js detected]"
  PKG_MGR="npm"
  [ -f "pnpm-lock.yaml" ] && PKG_MGR="pnpm"
  [ -f "yarn.lock" ] && PKG_MGR="yarn"
  echo "  Package manager: $PKG_MGR"

  HAS_LINT=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.lint ? 'yes' : 'no')" 2>/dev/null || echo "no")
  HAS_TEST=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.test ? 'yes' : 'no')" 2>/dev/null || echo "no")
  HAS_BUILD=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.build ? 'yes' : 'no')" 2>/dev/null || echo "no")
  HAS_TC=$(node -e "const p=require('./package.json'); console.log(p.scripts && (p.scripts['type-check'] || p.scripts.typecheck) ? 'yes' : 'no')" 2>/dev/null || echo "no")

  if [ ! -d "node_modules" ]; then
    echo "  ⚠️  node_modules not found. Run '$PKG_MGR install' first."
    FAIL=$((FAIL + 1))
  else
    [ "$HAS_LINT" = "yes" ]   && run_check "Lint"       "$PKG_MGR run lint"   || skip_check "Lint"  "no lint script"
    [ "$HAS_TC" = "yes" ]     && run_check "Type check" "$PKG_MGR run type-check 2>/dev/null || $PKG_MGR run typecheck" || skip_check "Type check" "no typecheck script"
    [ "$HAS_TEST" = "yes" ]   && run_check "Test"       "$PKG_MGR test"       || skip_check "Test"  "no test script"
    [ "$HAS_BUILD" = "yes" ]  && run_check "Build"      "$PKG_MGR run build"  || skip_check "Build" "no build script"
  fi
fi

# ── Python ──
if [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
  echo ""
  echo "[Python detected]"
  command -v ruff     >/dev/null 2>&1 && run_check "Lint (ruff)"  "ruff check ."      || skip_check "Lint (ruff)"  "ruff not installed"
  command -v flake8   >/dev/null 2>&1 && run_check "Lint (flake8)" "flake8 ."         || true
  command -v mypy     >/dev/null 2>&1 && run_check "Type check"   "mypy ."            || skip_check "Type check" "mypy not installed"
  command -v pytest   >/dev/null 2>&1 && run_check "Test (pytest)" "pytest"           || skip_check "Test" "pytest not installed — run: pip install pytest"
fi

# ── PHP / Laravel ──
if [ -f "composer.json" ]; then
  echo ""
  echo "[PHP/Composer detected]"
  command -v php >/dev/null 2>&1 || { echo "  ⚠️  PHP not found in PATH"; FAIL=$((FAIL + 1)); }
  [ -f "artisan" ] && run_check "Test (artisan)" "php artisan test" || \
  (grep -q '"test"' composer.json 2>/dev/null && run_check "Test (composer)" "composer test") || \
  skip_check "Test" "no test script found"
fi

# ── Java / Maven ──
if [ -f "pom.xml" ]; then
  echo ""
  echo "[Java/Maven detected]"
  command -v mvn >/dev/null 2>&1 && run_check "Test (mvn)" "mvn test -q" || skip_check "Test" "mvn not installed"
fi

# ── Java / Gradle ──
if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
  echo ""
  echo "[Gradle detected]"
  GRADLE_CMD="./gradlew"
  [ ! -f "./gradlew" ] && GRADLE_CMD="gradle"
  command -v gradle >/dev/null 2>&1 || [ -f "./gradlew" ] && run_check "Test (gradle)" "$GRADLE_CMD test" || skip_check "Test" "gradle not found"
fi

# ── .NET ──
if ls *.csproj *.sln 2>/dev/null | grep -q .; then
  echo ""
  echo "[.NET detected]"
  command -v dotnet >/dev/null 2>&1 && run_check "Build" "dotnet build -q" && run_check "Test" "dotnet test --no-build -q" || skip_check "Test" "dotnet not installed"
fi

# ── Go ──
if [ -f "go.mod" ]; then
  echo ""
  echo "[Go detected]"
  command -v go >/dev/null 2>&1 && run_check "Test" "go test ./..." || skip_check "Test" "go not installed"
fi

# ── Rust ──
if [ -f "Cargo.toml" ]; then
  echo ""
  echo "[Rust detected]"
  command -v cargo >/dev/null 2>&1 && run_check "Test" "cargo test" || skip_check "Test" "cargo not installed"
fi

# ── Makefile fallback ──
if [ -f "Makefile" ] && [ $((PASS + FAIL)) -eq 0 ]; then
  echo ""
  echo "[Makefile detected — trying common targets]"
  grep -q "^test:" Makefile && run_check "Test (make)" "make test" || skip_check "Test" "no 'test' target"
  grep -q "^lint:" Makefile && run_check "Lint (make)" "make lint" || true
fi

echo ""
echo "=============================="
echo "  Results: ✅ $PASS  ❌ $FAIL  ⏭  $SKIP"
echo "=============================="

if [ $FAIL -gt 0 ]; then
  exit 1
fi
