# What was fixed (compared with the first zip)

| # | Problem found | Fix |
|---|---|---|
| 1 | "Connect GitHub" was a fake button with demo repositories; the backend had no GitHub code | Real GitHub connection (token or OAuth), live repo/branch picker, scan started through GitHub Actions (`githubService.js`, `scan-repository.yml`) |
| 2 | Dashboard read only `localStorage` mock data | Frontend now uses the API for everything (`api.js`, `DataContext.jsx`, `pages.jsx`); login/register are real |
| 3 | Three different scoring formulas (security/, pipeline/, backend) | One formula, defined in `security/config.json`; backend copy checked by a test; `pipeline/scripts` removed |
| 4 | Workflow bypassed the Python security module | New workflow calls `normalize.py` and `gate.py` directly |
| 5 | `DEMO_MODE` could override the real gate | Removed together with the demo scripts and sample reports |
| 6 | Field-name mismatch (`score` / `security_score`, `Pass` / `PASS`) | Backend serializers return the names the UI uses; payload bridge extended |
| 7 | Gate "configurable" in name only | Per-project rules (min score, max High, block on Critical / secrets, require all scanners) editable on the Security Gate page and used by both the Python gate and backend |
| 8 | Deployment was a JSON file with a fake URL | Passing apps are deployed with `vercel deploy`; URL stored and shown; failures reported |
| 9 | Dependency-Check scanned only `frontend/` | Scans the whole cloned repository |
| 10 | Dockerfile only for the frontend and with a wrong layout | Trivy builds and scans the scanned repo's own Dockerfile when it has one; frontend Dockerfile fixed |
| 11 | Backend README said gate score 60, code used 70 | Docs rewritten to match the code |
| 12 | Any logged-in user could read any project/scan/findings | Ownership checked in every query |
| 13 | Anyone could POST results to any scan | Workflow endpoints require an HMAC signature, only for open scans, once |
| 14 | `process.exit` on idle DB error, no pooling for serverless, per-row inserts | Pool tuned for Vercel, `DATABASE_URL` support, one bulk insert |
| 15 | Gitleaks reports could contain secret values | `--redact` added; raw reports are never uploaded |
