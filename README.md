# qodo-standard-review

**Quota-free Qodo-standard code review** — local PR memory, security audit, and iterative review-loop. No API quota.

> Drop-in replacement for `qodo-review` / `coderabbitai/code-review` when VSCode extensions hit quota. 100% local LLM tokens.

## Why ?

- `mattpocock/code-review` (486K) etc. have no PR memory or hit API quota — this adds local `git log` → `.review-memory.json` + `AGENTS.md` learning loop, same rigor as Qodo's hosted vector DB, zero billing.

## Install (quota-free)

```bash
npx skills add Chandu/qodo-standard-review --skill qodo-standard-review -g
# or local dev
npx skills add ./qodo-standard-review --skill qodo-standard-review -g
```

Requires no `qodo` CLI, no CodeRabbit token.

## Usage

```bash
./scripts/memory.sh              # sync recent PRs
./scripts/review.sh              # review staged diff
./scripts/review.sh --range main...HEAD
```

In agent:

> "review this PR with qodo-standard-review, quality gate 8, use review-loop"

Composes with: `review-loop` + `security-review` + `code-review-excellence`.

## SEO

Tags: `code-review`, `pr-review`, `security-review`, `qodo`, `review-loop`, `code-quality`

Leaderboard goal: beat `code-review` (486K) via `qodo` + `quota-free` niche.

## License

MIT
