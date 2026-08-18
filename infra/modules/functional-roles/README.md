# Functional Roles

One account role per data-pipeline responsibility, instantiated once per source (e.g. `NORTHWIND_ANALYST_DEV`). Each role is granted up to `SYSADMIN` so objects it creates stay visible/manageable by account admins, and each is wired to exactly one warehouse from `modules/warehouses` for its own workload.

Grants are identical across dev/staging/prod — environment only changes naming, not access.

| Role | Responsible for | Scope | Warehouse |
|---|---|---|---|
| **analyst** | Reading business-ready data | `SELECT` on `MARTS` only (current + future tables/views) | `reporting` |
| **deployer** | Standing up and tearing down the dbt project | `CREATE`/`ALTER`/`DROP` on the native Snowflake `DBT PROJECT` object, plus schema-level DDL (`CREATE TABLE`/`CREATE VIEW`) on `STAGING`, `INTERMEDIATE`, `MARTS` to scaffold the transformation layer | `deploy` |
| **engineer** | Ad hoc / exploratory data engineering work | `CREATE SCHEMA` in the source database only — never on the terraform-managed schemas (`LANDING`, `STAGING`, `INTERMEDIATE`, `MARTS`). Sandbox schemas follow a naming convention (e.g. `ENG_*`) to avoid colliding with those | `adhoc` |
| **ingestor** | All raw-data landing logic | `CREATE TABLE` / `CREATE STAGE` / `CREATE FILE FORMAT` / `CREATE PIPE` — scoped only to `LANDING` | `loading` |
| **transformer** | Running the dbt project / doing transformations | `SELECT` on `LANDING` (current + future); `CREATE TABLE`/`CREATE VIEW` on `STAGING`, `INTERMEDIATE`, `MARTS`; `USAGE` (execute) on the `DBT PROJECT` object deployer creates. Deliberately narrower than deployer — no schema-level create/drop, so a routine run can't take out a whole schema | `transforming` |

## Notes / open follow-ups

- `LANDING`/`STAGING`/`INTERMEDIATE`/`MARTS` schemas are created and owned by `source-setup` (via the `resouceadmin` provider), not by any functional role — these role modules receive grants on them, they don't own them.
- Future grants (e.g. analyst → `MARTS`, transformer → `LANDING`, transformer → the `DBT PROJECT`) must be declared by whoever owns/manages those schemas, so they belong in the per-source RBAC wiring layer, not inside an individual role module.
- The engineer naming convention (`ENG_*` or similar) isn't enforceable by Snowflake privileges alone — it's a process/review convention, not a technical guardrail.
