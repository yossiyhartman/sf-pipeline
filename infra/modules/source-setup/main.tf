resource "snowflake_database" "db" {
  name                        = "${upper(var.source_name)}_${upper(var.environment)}"
  data_retention_time_in_days = var.data_retention_time_in_days

  comment = "Silo'd database for the ${var.source_name} source (${var.environment})."
}


resource "snowflake_schema" "ingestion_schema" {
  database = snowflake_database.db.fully_qualified_name
  name     = var.ingestion_schema

  comment = "Ingestion schema (${var.ingestion_schema}) for ${var.source_name} (${var.environment})."
}

resource "snowflake_schema" "transformation_schemas" {
  for_each = toset(var.transformation_schemas)
  database = snowflake_database.db.fully_qualified_name
  name     = each.value

  comment = "Transformation schema (${each.value}) for ${var.source_name} (${var.environment})."
}

resource "snowflake_schema" "target_schema" {
  database = snowflake_database.db.fully_qualified_name
  name     = var.target_schema

  comment = "Target schema (${var.target_schema}) for ${var.source_name} (${var.environment})."
}

resource "snowflake_schema" "dbt_project_schema" {
  database = snowflake_database.db.fully_qualified_name
  name     = var.dbt_project_schema

  comment = "DBT Projects Schema (${var.dbt_project_schema}) for ${var.source_name} (${var.environment})."
}

resource "snowflake_schema" "observability_schema" {
  database = snowflake_database.db.fully_qualified_name
  name     = var.observability_schema

  comment = "DBT Projects Schema (${var.observability_schema}) for ${var.source_name} (${var.environment})."
}
