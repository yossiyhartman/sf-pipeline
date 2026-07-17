terraform {
  backend "s3" {
    bucket       = "sandbox-snowflake-platform"
    region       = "eu-north-1"
    key          = "state/dev"
    use_lockfile = true
  }
}
