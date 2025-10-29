data "terraform_remote_state" "base_network" {
  backend = "s3"
  config = {
    bucket  = "terraform-backend-89972986"
    key     = "base-network/terraform.tfstate"
    region  = "ap-southeast-1"
    profile = "plasabas-general-admin"
  }
}
