# TechShield: Cloud-Based DevSecOps Platform

Connect a GitHub repository, detect vulnerabilities automatically (code, dependencies, secrets, containers), see everything in one
dashboard, and deploy to Vercel only if a configurable security gate passes.

```
frontend/   React dashboard                       -> Vercel
backend/    Express API + PostgreSQL              -> Vercel + Neon (free)
security/   Scanners, normalizer, score, gate     -> runs on GitHub Actions
.github/    scan-repository.yml (the scan engine), platform-ci.yml (tests)
docs/       SETUP.md (step by step), CHANGES.md
```

Start with **docs/SETUP.md**.

Tests: `cd security && python -m unittest discover -s tests` · `cd backend && npm test` · `cd frontend && npm run build`
