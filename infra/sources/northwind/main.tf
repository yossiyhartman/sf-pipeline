# config
locals {
  source_name  = "northwind"
  schemas      = ["RAW", "STAGING", "INTERMEDIATE", "MARTS"]
  stage_schema = "RAW"
}

# Create database with schemas
module "database_with_schemas" {
  source = "../../modules/database_scaffold"

  environment = var.environment
  source_name = local.source_name
  schemas     = local.schemas
}

# Create the staging
resource "snowflake_file_format" "raw_csv" {
  database = module.database_with_schemas.database_name
  schema   = local.stage_schema
  name     = "CSV_DEFAULT"

  format_type                    = "CSV"
  field_delimiter                = ","
  skip_header                    = 1
  field_optionally_enclosed_by   = "\""
  empty_field_as_null            = true
  error_on_column_count_mismatch = false
  trim_space                     = true

  comment = "Default CSV format for landing ${local.source_name} raw files."
}

resource "snowflake_stage_internal" "raw_landing" {
  database = module.database_with_schemas.database_name
  schema   = local.stage_schema
  name     = "RAW_LANDING"

  file_format {
    format_name = snowflake_file_format.raw_csv.fully_qualified_name
  }

  encryption {
    snowflake_sse {}
  }

  comment = "Landing stage for ${local.source_name} raw CSV files, ahead of COPY INTO."
}
