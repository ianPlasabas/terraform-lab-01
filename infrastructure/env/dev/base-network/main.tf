module "vpc" {
  source    = "git::https://github.com/ianPlasabas/terraform-network-module.git//vpc?ref=v1.0.0"
  vpc_block = "10.16.0.0/16"

  subnets = {
    web-1 = { cidr = "10.16.0.0/20", az = "ap-southeast-1a" }
    web-2 = { cidr = "10.16.16.0/20", az = "ap-southeast-1b" }
    app-1 = { cidr = "10.16.32.0/20", az = "ap-southeast-1a" }
    app-2 = { cidr = "10.16.48.0/20", az = "ap-southeast-1b" }
    app-3 = { cidr = "10.16.64.0/20", az = "ap-southeast-1a" }
    db-2  = { cidr = "10.16.80.0/20", az = "ap-southeast-1b" }
  }
}

module "web_routes" {
  source = "git::https://github.com/ianPlasabas/terraform-network-module.git//routes?ref=v1.0.0"

  routes = {
    igw_route = {
      route_table_id         = module.vpc.web-rt-id
      destination_cidr_block = "0.0.0.0/0"
      gateway_id             = module.vpc.igw_id
    }
  }
}

module "app_routes" {
  source = "git::https://github.com/ianPlasabas/terraform-network-module.git//routes?ref=v1.0.0"

  routes = {
    nat_route_a = {
      route_table_id         = module.vpc.app-rt-id["app-1"]
      destination_cidr_block = "0.0.0.0/0"
      nat_gateway_id         = module.vpc.nat_id["web-1"]
    }
    nat_route_b = {
      route_table_id         = module.vpc.app-rt-id["app-2"]
      destination_cidr_block = "0.0.0.0/0"
      nat_gateway_id         = module.vpc.nat_id["web-2"]
    }
  }
}

module "db" {
  source = "git::https://github.com/ianPlasabas/terraform-network-module.git//routes?ref=v1.0.0"

  routes = {
    db_route_b = {
      route_table_id         = module.vpc.db-rt-id["db-2"]
      destination_cidr_block = "0.0.0.0/0"
      nat_gateway_id         = module.vpc.nat_id["web-2"]
    }
  }
}

#Comment