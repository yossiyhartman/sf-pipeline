terraform {
  backend "s3" {
    bucket       = "sandbox-snowflake-platform"
    region       = "eu-north-1"
    key          = "state/dev/terraform.state"
    use_lockfile = true
  }
}
