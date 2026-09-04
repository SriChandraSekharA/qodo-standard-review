# Qodo-Standard 4-Lens Checklist (Quota-Free)

## 1. Correctness
- [ ] Edge cases handled (empty, null, 0, boundary)
- [ ] Off-by-one, race conditions, async error handling
- [ ] Null/undefined checks

## 2. Security (from security-review)
- [ ] Input validated/sanitized, SQL parameterized, XSS escaped
- [ ] AuthZ before action, JWT expiry/signature, secrets not hardcoded
- [ ] No eval, no SSRF, file upload limits

## 3. Quality
- [ ] Naming clear, functions single-purpose, no duplication
- [ ] Architecture fit, no N+1

## 4. Tests
- [ ] Happy + edge + error paths, deterministic, behavior-focused
