# Shared
# #######

module "warehouses" {
  source = "./modules/warehouses"

  environment = var.environment

  warehouses = {
    adhoc = { size = "XSMALL", auto_suspend = 60 }

    # Later you would like to create a warehouse for different funcitonalities such as:
    # loading      = { size = "XSMALL", auto_suspend = 60 }
    # transforming = { size = "XSMALL", auto_suspend = 60 }
    # reporting    = { size = "XSMALL", auto_suspend = 60 }
  }
}


# Sources
# #######
#

module "source_northwind" {
  source      = "./sources/northwind"
  environment = var.environment

}
