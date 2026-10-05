# Run locally on Windows (VS Code)

You need: Node.js 20+, PostgreSQL (remember the password of the `postgres` user).

## 1. Backend (terminal 1)
```powershell
cd backend
npm install
copy .env.example .env
```
Open `backend\.env` and set:
- `DB_PASSWORD=` your real PostgreSQL password (no quotes, no spaces)
- `JWT_SECRET`, `TOKEN_ENC_KEY`, `SCAN_SECRET` = three long random strings. Generate each with:
  `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`

Save the file, then start:
```powershell
npm run dev
```
You should see `Backend running on http://localhost:5000` followed by `Database ready (tables are up to date).`
The backend creates the `devsecops` database and all tables by itself in development.
If something is wrong with the database, it prints `DATABASE PROBLEM: ...` with the fix.

## 2. Frontend (terminal 2)
```powershell
cd frontend
npm install
copy .env.example .env
npm run dev
```
Open http://localhost:5173, register, then log in.

Restart a server after changing its `.env` file. Keep both terminals open.
