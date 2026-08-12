locals {
  source_name          = "NORTHWIND"
  name_ingestion_layer = "LANDING"
}

# Scaffold a project
# 01 - Creates a DB for each environment with predefined schemas

module "database_scaffold" {
  source = "../../modules/initialise-database"

  environment = var.environment

  source_name = local.source_name
  schemas     = [local.name_ingestion_layer, "STAGING", "INTERMEDIATE", "MARTS"]
}

# Setup the ingestion
# 01 - determine the shape of the incomming dats
# 02 - provide a stage where the data should land

resource "snowflake_file_format_csv" "csv_format" {
  database = module.database_scaffold.database_name.fully_qualified_name
  schema   = module.database_scaffold.schema_names[local.name_ingestion_layer].name
  name     = "${local.source_name}_CSV_INGESTION_FORMAT"

  compression                    = "NONE"
  field_delimiter                = ","
  field_optionally_enclosed_by   = "\""
  multi_line                     = "true"
  file_extension                 = ".csv"
  skip_header                    = 1
  skip_blank_lines               = "true"
  encoding                       = "UTF8"
  error_on_column_count_mismatch = "false"
  empty_field_as_null            = "true"
  null_if                        = ["NULL", ""]
  comment                        = "Northwind CSV ingestion format"
}

resource "snowflake_stage_internal" "ingestion_stage" {
  name     = "${local.source_name}_STAGE"
  database = module.database_scaffold.database_name.fully_qualified_name
  schema   = module.database_scaffold.schema_names[local.name_ingestion_layer].name

  file_format {
    format_name = snowflake_file_format_csv.csv_format.fully_qualified_name
  }
}
