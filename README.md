# Claude Code Output System

A reusable setup for Claude Code that enforces a structured workflow loop across any repository.

## What This Is

A set of configuration files (skills, agents, commands, docs) that turn Claude Code into a structured engineering assistant. Drop it into any repo and run `/init-project` to get started.

**Loop:**
```
Understand → Clarify → Spec → Plan → Implement → Check → Review → Improve → Ship
```

## Quick Start

```bash
# 1. Copy this system into your repo (if not already there)
#    .claude/, docs/, scripts/, templates/, CLAUDE.md, AGENTS.md

# 2. Make scripts executable (Unix/Mac)
chmod +x scripts/check.sh scripts/dev.sh

# 3. Let Claude read and understand your repo
```

Then in Claude Code:
```
/init-project
```

## Commands

| Command | Description |
|---------|-------------|
| `/init-project` | Read repo, detect stack, fill PROJECT_CONTEXT & RUNBOOK |
| `/clarify <requirement>` | Turn vague requirement into a clear spec |
| `/fast-feature <feature>` | Implement smallest working slice |
| `/fix-bug <error>` | Find root cause, apply minimal fix |
| `/goal-loop <goal>` | Break down large goal, execute step by step |
| `/review` | Review current git diff |
| `/ship` | Run test gate + review before committing |
| `/checkpoint` | Save current state to TASKS.md |

## Development

> Run `/init-project` first to detect your stack and fill in the commands below.

### Start dev server

```bash
# Unix/Mac
bash scripts/dev.sh

# Windows
.\scripts\dev.ps1

# Or use the command detected by /init-project (see docs/RUNBOOK.md)
```

### Run checks (lint + test + build)

```bash
# Unix/Mac
bash scripts/check.sh

# Windows
.\scripts\check.ps1
```

Scripts auto-detect your stack (Node.js, Python, PHP, Java, .NET, Go, Rust) and run the appropriate commands. No installation required — they report clearly if a tool is missing.

### After `/init-project`

Actual commands will be filled into `docs/RUNBOOK.md`. Example for a Node.js project:

```bash
npm run dev       # dev server
npm test          # run tests
npm run lint      # lint
npm run build     # build for production
```

## Project Docs

| File | Purpose |
|------|---------|
| `docs/PROJECT_CONTEXT.md` | Stack, structure, entry points |
| `docs/RUNBOOK.md` | Commands to run/test/build the app |
| `docs/TASKS.md` | Current tasks and backlog |
| `docs/BUGS.md` | Bug log |
| `docs/DECISIONS.md` | Technical decisions |
| `docs/ARCHITECTURE.md` | System diagram |

## Structure

```
.claude/
├── skills/          # Domain knowledge Claude draws on automatically
├── agents/          # Specialist roles (Planner, Coder, Tester, ...)
└── commands/        # Slash commands you invoke explicitly
docs/                # Living documentation filled by /init-project
scripts/             # check.sh/ps1, dev.sh/ps1
templates/           # FEATURE_SPEC, BUG_REPORT, PR_TEMPLATE
CLAUDE.md            # Rules and constraints for Claude
AGENTS.md            # Agent roles and coordination diagram
```

## Adapting to Your Repo

1. Run `/init-project` — Claude reads your codebase and fills `docs/`.
2. Edit `docs/RUNBOOK.md` if auto-detection missed something.
3. Add company-specific context to `docs/PROJECT_CONTEXT.md`.
4. Adjust skill files in `.claude/skills/` for your team's workflows.

## License

MIT
