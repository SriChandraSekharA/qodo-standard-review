# Security Policy

## Supported Versions

Only the canonical repo `SriChandraSekharA/forge-standard` receives security updates. Legacy repos `anvil-review-loop` and `qodo-standard-review` are pending archive and will not receive patches. Please use `forge-standard` for any new work.

| Repo | Version | Supported |
|------|---------|-----------|
| `SriChandraSekharA/forge-standard` | `v1.0.0` and later | Yes |
| `SriChandraSekharA/anvil-review-loop` | all | No, moved |
| `SriChandraSekharA/qodo-standard-review` | all | No, moved |

## Reporting a Vulnerability

Do not open a public issue for security reports.

- Email: `chandrashekar.adepalli@kfintech.com`
- Include: repo, commit SHA, steps to reproduce, impact, and suggested fix if any
- You will get an acknowledgement within 72 hours and a status update within 7 days

We follow coordinated disclosure. Please give us reasonable time to fix before public disclosure.

## Scope

This policy covers code in `scripts/`, `references/`, `templates/`, and any MCP server added under `mcp/` in the canonical repo. The review loop runs fully offline, no tokens are required, so no credential disclosure is in scope.

## Archive Notice

These legacy repos will be archived with a redirect to `SriChandraSekharA/forge-standard`. After archival, open new security reports against `forge-standard` only.
