## Snowflake Data Platform

This repo implements a lightweight, production-ready setup for a Snowflake data platform.

| Tech       | Description                                                                |
| ---------- | --------------------------------------------------------------------------- |
| SQL        | Runs primarily within Snowflake, executed via the Snowflake CLI (`snow`)    |
| dbt        | Standard tool for transformations within Snowflake                          |
| Python     | Used for setup scripts                                                      |
| UV         | Manages Python packages via `pyproject.toml`                                |
| AWS        | Used for infrastructure state and as a data source                          |
| go-task    | Task runner and orchestrator                                                |
| pre-commit | Enforces code quality standards (linting, formatting, commit template)      |

## Documentation

See [references](./docs/references.md) for links to relevant documentation.

## Best Practices

- When in doubt, consult the documentation.
- Always provide a short description of what each function, method, resource, or variable does or represents.
