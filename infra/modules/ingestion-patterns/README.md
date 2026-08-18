# Ingestion Patterns

Ingestion mechanics vary per source (batch via internal stage, snowpipe, streaming, ...), so — unlike the generic `functional-roles/*` modules — these aren't self-contained roles. Each module takes an existing role name (typically the ingestor role from `functional-roles/ingestor`) and grants only the privileges that specific ingestion mechanism needs.

A source can compose more than one pattern against the same ingestor role if it ingests data more than one way — the grants just stack.

| Module | Grants | Use for |
|---|---|---|
| `internal-stage` | `CREATE TABLE`, `CREATE STAGE`, `CREATE FILE FORMAT` on the landing schema | Batch loads via `PUT`/`COPY INTO` against an internal stage (Northwind's current setup) |

Add new pattern modules here as new ingestion mechanics show up (e.g. `snowpipe-streaming` would add `CREATE PIPE` + `USAGE` on a notification integration) — don't add conditionals to the existing ones.
