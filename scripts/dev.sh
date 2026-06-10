#!/usr/bin/env bash
# scripts/dev.sh — Khởi động dev server
# Tự phát hiện command. Không cài package.

echo "=============================="
echo "  Dev Server"
echo "=============================="

# ── Node.js ──
if [ -f "package.json" ]; then
  PKG_MGR="npm"
  [ -f "pnpm-lock.yaml" ] && PKG_MGR="pnpm"
  [ -f "yarn.lock" ] && PKG_MGR="yarn"

  HAS_DEV=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.dev ? 'yes' : 'no')" 2>/dev/null || echo "no")
  HAS_START=$(node -e "const p=require('./package.json'); console.log(p.scripts && p.scripts.start ? 'yes' : 'no')" 2>/dev/null || echo "no")

  if [ ! -d "node_modules" ]; then
    echo "⚠️  node_modules not found. Run '$PKG_MGR install' first."
    exit 1
  fi

  if [ "$HAS_DEV" = "yes" ]; then
    echo "▶ Running: $PKG_MGR run dev"
    exec $PKG_MGR run dev
  elif [ "$HAS_START" = "yes" ]; then
    echo "▶ Running: $PKG_MGR start"
    exec $PKG_MGR start
  else
    echo "⚠️  No 'dev' or 'start' script found in package.json"
    echo "   Update docs/RUNBOOK.md with the correct dev command."
    exit 1
  fi
fi

# ── Python / FastAPI / Django / Flask ──
if [ -f "pyproject.toml" ] || [ -f "manage.py" ] || [ -f "app.py" ] || [ -f "main.py" ]; then
  if [ -f "manage.py" ]; then
    echo "▶ Running: python manage.py runserver"
    exec python manage.py runserver
  elif grep -q "fastapi\|uvicorn" pyproject.toml 2>/dev/null; then
    echo "▶ Running: uvicorn main:app --reload"
    exec uvicorn main:app --reload
  elif [ -f "app.py" ]; then
    echo "▶ Running: python app.py"
    exec python app.py
  else
    echo "⚠️  Python project detected but dev command unclear."
    echo "   Update docs/RUNBOOK.md with the correct dev command."
    exit 1
  fi
fi

# ── PHP / Laravel ──
if [ -f "artisan" ]; then
  echo "▶ Running: php artisan serve"
  exec php artisan serve
fi

# ── Không xác định được ──
echo "⚠️  Could not detect dev server command."
echo "   Please update docs/RUNBOOK.md with:"
echo "   'Dev server: <your command here>'"
exit 1
