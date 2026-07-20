resource "snowflake_database" "this" {
  name                        = "${upper(var.source_name)}_${upper(var.environment)}"
  data_retention_time_in_days = var.data_retention_time_in_days

  comment = "Silo'd database for the ${var.source_name} source (${var.environment})."
}

resource "snowflake_schema" "this" {
  for_each = toset(var.schemas)
  database = snowflake_database.this.name
  name     = each.value

  comment = "${each.value} layer for ${var.source_name} (${var.environment})."
}
