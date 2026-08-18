# Batch ingestion via internal stage: files are PUT onto an internal stage
# and COPY INTO'd against a file format, both defined in the landing schema.

resource "snowflake_grant_privileges_to_account_role" "internal_stage_ingestion" {
  account_role_name = var.role_name
  privileges        = ["CREATE TABLE", "CREATE STAGE", "CREATE FILE FORMAT"]

  on_schema {
    schema_name = var.ingestion_schema
  }
}
