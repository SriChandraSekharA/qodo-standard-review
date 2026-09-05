# Archived - moved to forge-standard

> **Archived - moved to forge-standard**

This repository is archived and no longer maintained. All active development has moved to the canonical repo.

**Canonical:** [`SriChandraSekharA/forge-standard`](https://github.com/SriChandraSekharA/forge-standard)

**MOVED to SriChandraSekharA/forge-standard**

## Why archived

- Consolidation: `anvil-review-loop` and `qodo-standard-review` were legacy iterations of the same review loop idea.
- Canonical choice: `forge-standard` is the distinct brand with `forge-standard` skill name, 8 topics, MIT license, and offline quota-free loop.
- Maintenance window: keeping three repos diverged the docs and confused `skills.sh` discovery. One canonical removes that drift.

## What this means

- This repo is read-only, issues and PRs are closed.
- No new releases, no security patches here, see `SECURITY.md`.
- History and tags remain for reference.

## How to move

```bash
# if you installed the legacy skill
npx skills remove anvil-review-loop 2>/dev/null; npx skills remove qodo-standard-review 2>/dev/null

# install the canonical
npx --yes skills add SriChandraSekharA/forge-standard --skill forge-standard -g -y

# migrate per-repo memory if you used the legacy loop
# .anvil-review-loop/ or .review-memory.json -> .forge-standard/ is recreated on next ./scripts/init.sh
./scripts/init.sh
```

## References

- Canonical README: https://github.com/SriChandraSekharA/forge-standard#readme
- SKILL.md: https://github.com/SriChandraSekharA/forge-standard/blob/main/SKILL.md
- Audit: see `SriChandraSekharA/forge-standard/.omo/audit.md` for the 3-repo gap matrix (HEADs `685c52c` and `53319ab` archived here)

> Draft notice only, archive not yet executed. The `gh repo archive` step is deferred to Task 9 after skills.sh propagation is confirmed. Do not treat this file as proof of archival until the repo shows `archived:true` via `gh api`.
