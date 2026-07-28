# Bootcamp Postgres container (port 10001)

## 1. Run it

Put `docker-compose.yml`, `Dockerfile`, and an empty `init-scripts/` folder in
`/Users/roy/neue-fische/week_03/ds-sql-intro` (or anywhere — just keep the three
together), then:

```bash
cd /Users/roy/neue-fische/week_03/ds-sql-intro
docker compose up -d
```

Check it's healthy:

```bash
docker compose ps
```

To load bootcamp seed data (if your course gives you `.sql` files), drop them
into `init-scripts/` **before the first `docker compose up`** — Postgres only
runs them on an empty database. If you already started the container, either
delete the `ds_sql_intro_data` volume (`docker compose down -v`) and restart,
or just run the `.sql` file manually with `psql` / DBeaver's SQL editor.

## 2. Connect DBeaver

New connection → PostgreSQL, with:

| Field    | Value           |
|----------|-----------------|
| Host     | `localhost`     |
| Port     | `10001`         |
| Database | `ds_sql_intro`  |
| Username | `bootcamp`      |
| Password | `bootcamp`      |

Test Connection → Finish.

## 3. GitHub Copilot as DBeaver's AI engine

This is a DBeaver app setting, unrelated to the container — DBeaver 26.1+
supports Copilot directly:

1. DBeaver → Settings (or Preferences) → Editors → AI Assistant → Engines.
2. Choose **GitHub Copilot** as the engine.
3. Sign in with your GitHub account and complete the OAuth flow (requires an
   active Copilot subscription or trial).
4. Enable AI Assistant / smart completion in the SQL editor settings.

Once connected, Copilot-backed suggestions appear as you type SQL and you can
use DBeaver's "Ask AI" panel to generate or explain queries.

Docs: https://dbeaver.com/docs/dbeaver/AI-integration-with-GitHub-Copilot/

## Notes

- Change `POSTGRES_PASSWORD` in `docker-compose.yml` if you don't want a
  throwaway default — this is just a local learning DB.
- Data persists in the `ds_sql_intro_data` Docker volume across restarts. Wipe
  it with `docker compose down -v` if you want a clean slate.
