## Plan: Docker Compose + start/stop scripts for exploring `landon-hotel`

TL;DR: Create a `docker-compose.yml` at the repo root to run PostgreSQL (and optional Adminer) and add start/stop scripts (`scripts/start.sh`, `scripts/stop.sh`, `scripts/start.ps1`, `scripts/stop.ps1`). Default workflow: run Postgres in Docker and run the chosen `landon-hotel` app locally with Maven. Optionally containerize the app(s) with a `Dockerfile` and add them to compose.

**Steps**
1. Choose target chapter with DB init SQL (depends on user: default `05_04_end`).
2. Create `docker-compose.yml` at repo root with:
   - Service `postgres` using `postgres:15`.
   - Env: `POSTGRES_DB=local`, `POSTGRES_USER=postgres`, `POSTGRES_PASSWORD=postgres`, `PGDATA=/var/lib/postgresql/data/pgdata`.
   - Persistent volume `postgres_data`.
   - Optional mounts of the chosen chapter's `schema.sql` and `data.sql` into `/docker-entrypoint-initdb.d/` to auto-initialize.
   - Optional service `adminer` (DB UI) mapped to host `8081`.
3. Add start/stop scripts at `scripts/`:
   - `scripts/start.sh` (Bash): `docker-compose up -d postgres adminer`, wait loop until Postgres is ready (`pg_isready` via `docker-compose exec`), print `docker-compose ps`.
   - `scripts/stop.sh` (Bash): `docker-compose down`.
   - `scripts/start.ps1` / `scripts/stop.ps1` with equivalent PowerShell logic for Windows.
4. Optional: add a `Dockerfile` to the chosen chapter (example path `05_04_end/landon-hotel/Dockerfile`) and an app service in `docker-compose.yml` using `build:`. When containerizing, set app env vars so the datasource URL points to `postgres` service (e.g., `SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/local?currentSchema=LIL`).
5. Verification: run the start script, confirm `docker-compose ps`, check `docker logs postgres --tail 50`, then run the app locally via `mvn -f <chapter>/pom.xml spring-boot:run` and exercise endpoints (e.g., `curl http://localhost:8080/`). If containerized, curl the mapped port.
6. Commit files and optionally add a small README describing usage.

**Relevant files**
- Existing DB init scripts (examples): [05_04_end/bin/postgresql/schema.sql](05_04_end/bin/postgresql/schema.sql), [05_04_end/bin/postgresql/data.sql](05_04_end/bin/postgresql/data.sql)
- Existing example start script: [02_03_begin/bin/postgresql/start_postgres.sh](02_03_begin/bin/postgresql/start_postgresql.sh)
- Example application properties: [05_04_end/landon-hotel/src/main/resources/application.properties](05_04_end/landon-hotel/src/main/resources/application.properties)
- Example POM: [05_04_end/landon-hotel/pom.xml](05_04_end/landon-hotel/pom.xml)

**Files to create (will be added if you approve)**
- `docker-compose.yml` (repository root)
- `scripts/start.sh`, `scripts/stop.sh`
- `scripts/start.ps1`, `scripts/stop.ps1`
- Optional: `<chapter>/landon-hotel/Dockerfile` and docker-compose app service entries

**Verification**
1. Run `scripts/start.sh` (or `.\scripts\start.ps1` on PowerShell). Expect `postgres` and `adminer` containers running.
2. `docker-compose ps` should show `postgres` state `Up`.
3. `docker logs postgres --tail 50` should show startup and `database system is ready to accept connections`.
4. Run `mvn -f <chapter>/pom.xml spring-boot:run` and then `curl http://localhost:8080/` to verify the app connects to DB.

**Decisions / Assumptions**
- Use `local` database name and `postgres`/`postgres` credentials (matching many `application.properties`).
- Default approach is to run Postgres in Docker and run the app on host JVM (easier during development).
- If you containerize the app, update datasource to use the Compose service name `postgres` instead of `localhost`.
- Scripts will support both Bash and PowerShell to accommodate Windows + WSL.

**Further considerations**
1. Port collisions: multiple `landon-hotel` copies all default to `8080`. If you run more than one app/container, remap ports explicitly.
2. Which chapter to initialize from matters: the SQL schema and data vary. I recommend `05_04_end` for a recent, Postgres-backed example.

**Next actions (choose one)**
- I can create the `docker-compose.yml` and both start/stop script variants now (no-code changes to apps). 
- I can also add a sample `Dockerfile` and wire one `landon-hotel` into `docker-compose`.
- Or I can wait for your answers to the clarifying questions below.

(Plan saved to session memory.)