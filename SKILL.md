---
name: qodo-standard-review
description: Quota-free Qodo-standard code review — local PR memory, security audit, and iterative review-loop. No API quota. Learns from git history and AGENTS.md. Covers code review, PR review, and requesting-code-review standards. Use when reviewing code, PRs, or before merging.
---

# Qodo-Standard Review (Quota-Free)

Qodo/CodeRabbit-level rigor with **zero API quota**. 100% local LLM tokens. Replaces `qodo-review` / `code-review (coderabbitai)` for users hitting VSCode extension limits. Adds the one thing quota-free skills lacked: **PR memory loop**.

> **Quota-free promise:** No `qodo` CLI, no `coderabbitai` API, no token counter hit. Uses only `git`, `AGENTS.md`, `.review-memory.json`, and your local model — same interface as Qodo, none of the billing.

## Why This Beats Top Skills

| Leaderboard Top | Gap | This Skill |
|---|---|---|
| `mattpocock/code-review` 486K | No PR memory, single-pass | + `.review-memory.json` + git log memory + iterative loop |
| `addyosmani/code-review-and-quality` 36K | No security depth | + `security-review` lens included |
| `wshobson/code-review-excellence` 27K | Manual checklist | + automated `scripts/review.sh` |
| `2dmurali/review-loop` 51K | Generic loop | + Qodo-standard 4-lens scoring |
| `affaan-m/ecc@security-review` 15K | Security only | + correctness/quality/tests combined |
| `qodo-review` / `coderabbitai/code-review` | **Hits API quota** | **Zero quota — drop-in replacement** |

Keywords covered for skills.sh search: `code review`, `pr review`, `pull request review`, `security review`, `code quality`, `qodo`, `qodo review`, `codereview`, `requesting-code-review`, `review loop`.

## When to Use

- `review my PR` / `review this diff` / `qodo review` / `code review` / `pr review` / `security review`
- Before merge, after `git diff`, on staged changes, or on a PR branch
- When Qodo/CodeRabbit VSCode extensions are quota-blocked
- When you want Qodo's PR-learning loop without its hosted vector DB

## When NOT to Use

- One-liner typo fix (use `quick` review, no loop needed)
- Pure formatting/lint (let `Biome`/`Ruff` handle it — this skill skips style nits by default)
- You explicitly want hosted Qodo rules (then use `qodo-get-rules` — quota required)

## Quota-Free Qodo-Standard Workflow

### Phase 0 — Collect Context (local only, <2s)

```bash
./scripts/memory.sh        # sync git log -> .review-memory.json (last 10 PRs)
cat AGENTS.md              # project conventions (Qodo's "project context")
git diff --staged          # current change (or git diff origin/main...HEAD for PR)
cat .review-memory.json    # prior review learnings (replaces Qodo hosted DB)
```

### Phase 1 — 4-Lens Parallel Review (no API calls)

Run these lenses with local LLM (or via `review-loop` subagent):

1. **Correctness** — logic, edge cases, off-by-one, null handling, race conditions
2. **Security** — injection, XSS, authz, secrets, eval/ssrf (see `references/checklist.md`)
3. **Quality** — maintainability, naming, complexity, duplication, architecture fit
4. **Tests** — coverage, edge cases, determinism, behavior vs implementation

Each lens outputs: `🔴 blocking / 🟡 important / 🟢 nit / 💡 suggestion` with file:line.

### Phase 2 — Iterative Review Loop (replaces Qodo's hosted scoring)

Uses `review-loop` pattern locally:

1. Main agent does review → spawns **reviewer subagent** (fresh context, scores 1-10)
2. If score < 8 or < 2 loops done → revise findings, repeat (max 4 loops)
3. Final verdict: `✅ Approve` / `💬 Comment` / `🔄 Request Changes`

Reviewer prompt (copy-paste):

```
You are a critical Qodo-standard reviewer. Score this review 1-10.

## Review under test
{findings}

## Diff
{git diff}

## Criteria
- Blocking issues caught? Security covered? False positives minimized?
- Actionable, prioritized, not nitpicking style?
- Would Qodo approve this review?

Return: score, missing issues, over-nits to drop, and one-line verdict.
```

### Phase 3 — PR Learning Loop (replaces Qodo hosted vector DB)

After each review:

```bash
# Append to local memory (git-committed, survives across sessions)
jq --arg date "$(date -Iseconds)" \
   --arg findings "$(cat /tmp/review.json)" \
   '.reviews += [{"date": $date, "findings": $findings}]' \
   .review-memory.json > /tmp/m.json && mv /tmp/m.json .review-memory.json

# Suggest AGENTS.md update if pattern repeats (e.g., "always validate SQL params")
# Human approves — this is your local "Qodo rules" without API
```

## Commands

```bash
# Quick diff review (quota-free)
./scripts/review.sh                  # staged diff
./scripts/review.sh --range main...HEAD  # PR range
./scripts/review.sh --file src/app.ts    # single file

# Sync PR memory (run before review)
./scripts/memory.sh --limit 20

# Full Qodo-standard review via skill
# In opencode/claude: "review this PR with qodo-standard-review, quality gate 8"
```

## Severity Labels (Qodo-compatible)

- `🔴 [blocking]` — must fix before merge (security, correctness)
- `🟡 [important]` — should fix, discuss if disagree
- `🟢 [nit]` — nice to have, not blocking
- `💡 [suggestion]` — alternative approach
- `🎉 [praise]` — good work to keep

Output format per finding: `L42: 🔴 [blocking] <issue> — <fix>`

## Integration with Existing Quota-Free Skills

This skill **composes** — not replaces — your 6 installed quota-free skills:

- `review-loop` → iterative scoring (Phase 2)
- `code-review-excellence` / `code-review-and-quality` / `code-review (getsentry)` → lenses
- `security-review` → security lens
- `open-code-review (ocr)` → fallback `ocr review` command if you want CLI
- `caveman-review` → `Lxx: bug/risk/nit/q` line format

Invoke together: `review this PR with qodo-standard-review and security-review, use review-loop gate 8`

## References

- `references/checklist.md` — Qodo-standard 4-lens checklist (copy of Qodo's hosted rules, local)
- `scripts/review.sh` — local diff collector + lens runner (no API)
- `scripts/memory.sh` — git log → .review-memory.json sync

## SEO Notes for skills.sh

Title: **Qodo-Standard Review — Quota-Free PR Review with Local Memory**
Description: Quota-free Qodo-standard code review... (see frontmatter). Tags: `code-review`, `pr-review`, `security-review`, `qodo`, `review-loop`, `code-quality`.
