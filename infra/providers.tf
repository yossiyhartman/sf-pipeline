provider "snowflake" {
  preview_features_enabled = [
    "snowflake_file_formats_datasource",
    "snowflake_file_format_csv_resource",
  "snowflake_api_integration_git_repository_github_app"]
}
