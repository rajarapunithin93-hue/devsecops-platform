# Frontend (React + Vite)

The dashboard talks to the backend through `src/api.js`; all data comes from the API (nothing is mocked).

| File | Purpose |
|---|---|
| `src/api.js` | API client, JWT in `localStorage` |
| `src/DataContext.jsx` | Loads projects, polls every 5 s while a scan is running |
| `src/App.jsx` | Shell, login/register, notifications |
| `src/pages.jsx` | Dashboard, Projects, Connect GitHub, Scan Results, Score, Gate (with editable rules), History, Settings |

```bash
cp .env.example .env     # set VITE_API_BASE_URL
npm install
npm run dev              # http://localhost:5173
npm run build
```

Deploy on Vercel: import the repo, set **Root Directory = frontend**, add `VITE_API_BASE_URL`. `vercel.json` makes page refreshes work.
