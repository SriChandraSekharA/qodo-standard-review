# Contributing

Thanks for considering a contribution. This repo follows the same baseline as `SriChandraSekharA/forge-standard`.

## Quick Start

1. Fork and clone the repo.
2. Create a feature branch, e.g. `feat/my-change`.
3. Keep scripts idempotent and POSIX friendly, run `shellcheck` where applicable.
4. Add or update tests under `tests/` if behavior changes.
5. Run checks locally before opening a PR.

## Checks Before PR

- `shellcheck scripts/*.sh` should be clean
- `npm test` or `pytest` passes when tests exist
- Keep `SKILL.md` frontmatter to exactly `name` + `description` if you touch it
- Do not add API tokens or gated dependencies

## Commit and PR Guidelines

- Title format: `[scope] Brief description`
- Keep commits focused, one logical change per commit
- Describe what changed and why in the PR body
- Link any related issue

## Reporting Issues

Open an issue with steps to reproduce, expected vs actual behavior, and environment details.

## Code of Conduct

By participating you agree to follow the `CODE_OF_CONDUCT.md` in this repo.

## Security

Do not report vulnerabilities in public issues, see `SECURITY.md`.

## License

Contributions are made under the MIT license, same as `LICENSE`.
