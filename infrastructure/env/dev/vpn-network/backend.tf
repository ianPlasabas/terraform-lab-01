terraform {
  backend "s3" {
    bucket       = "terraform-backend-89972986"
    key          = "vpn-network/terraform.tfstate"
    region       = "ap-southeast-1"
    profile      = "plasabas-general-admin"
    use_lockfile = true
  }
}