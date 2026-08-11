######
# Account Setup
######

# complete resource
resource "snowflake_api_integration_git_repository_github_app" "github_integration_app" {
  name                 = "github_integraiton"
  api_allowed_prefixes = ["https://github.com/yossiyhartman"]
  enabled              = true
}


######
# Shared
######

module "warehouses" {
  source = "./modules/warehouses"

  environment = var.environment
  warehouses = {
    adhoc        = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
    loading      = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
    transforming = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
    reporting    = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
  }
}



#######
# Sources
#######

module "source_northwind" {
  source      = "./sources/northwind"
  environment = var.environment
}
