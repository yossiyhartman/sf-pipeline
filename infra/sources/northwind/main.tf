locals {
  source_name = "NORTHWIND"

  layers = {
    # In what layer does the data land? this can be none if data is already in snowflake
    ingestion = "LANDING"

    # the layers that are needed for the tranformations
    transformation = ["STAGING", "INTERMEDIATE", "MARTS"]

    # Layer that is made publicly available for analysis
    target = "MARTS"
  }
}

# Scaffold a project
# 01 - Creates a DB for each environment with predefined schemas

module "source_setup" {
  source = "../../modules/source-setup"

  environment            = var.environment
  source_name            = local.source_name
  ingestion_schema       = local.layers.ingestion
  transformation_schemas = local.layers.transformation
  target_schema          = local.layers.target

}



# Setup the ingestion
# 01 - determine the shape of the incomming dats
# 02 - provide a stage where the data should land

resource "snowflake_file_format_csv" "csv_format" {
  database = module.source_setup.database_name.fully_qualified_name
  schema   = module.source_setup.ingestion_schema_reference.name
  name     = "CSV_INGESTION_FORMAT"

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

  comment = "Northwind CSV ingestion format"
}

resource "snowflake_stage_internal" "ingestion_stage" {
  name     = "${local.source_name}_STAGE"
  database = module.source_setup.database_name.fully_qualified_name
  schema   = module.source_setup.ingestion_schema_reference.name

  file_format {
    format_name = snowflake_file_format_csv.csv_format.fully_qualified_name
  }
}

#######
# Functional roles
#######

locals {
  transformation_schema_fqns = [for s in module.source_setup.transformation_schemas_reference : s.fully_qualified_name]
}

module "analyst_role" {
  source = "../../modules/functional-roles/analyst"

  environment          = var.environment
  source_name          = local.source_name
  database_name        = module.source_setup.database_name.name
  target_schema        = module.source_setup.target_schema_reference.fully_qualified_name
  warehouse_usage_role = var.warehouse_usage_roles["reporting"]
}

module "deployer_role" {
  source = "../../modules/functional-roles/deployer"

  environment          = var.environment
  source_name          = local.source_name
  database_name        = module.source_setup.database_name.name
  dbt_project_schema   = local.transformation_schema_fqns
  warehouse_usage_role = var.warehouse_usage_roles["deploy"]
}

# module "engineer_role" {
#   source = "../../modules/functional-roles/engineer"

#   environment          = var.environment
#   source_name          = local.source_name
#   database_name        = module.source_setup.database_name.name
#   warehouse_usage_role = var.warehouse_usage_roles["adhoc"]
# }


# module "transformer_role" {
#   source = "../../modules/functional-roles/transformer"

#   environment            = var.environment
#   source_name            = local.source_name
#   database_name          = module.source_setup.database_name.name
#   ingestion_schema       = module.source_setup.ingestion_schema_reference.fully_qualified_name
#   transformation_schemas = local.transformation_schema_fqns
#   warehouse_usage_role   = var.warehouse_usage_roles["transforming"]
# }

# module "ingestor_role" {
#   source = "../../modules/functional-roles/ingestor"

#   environment          = var.environment
#   source_name          = local.source_name
#   database_name        = module.source_setup.database_name.name
#   warehouse_usage_role = var.warehouse_usage_roles["loading"]
# }

# # Northwind lands data as batch CSV files via internal stage — grant the
# # ingestor role the privileges that pattern needs in the landing schema.
# module "ingestion_internal_stage" {
#   source = "../../modules/ingestion-patterns/internal-stage"

#   role_name        = module.ingestor_role.ingestor_role
#   ingestion_schema = module.source_setup.ingestion_schema_reference.fully_qualified_name
# }
