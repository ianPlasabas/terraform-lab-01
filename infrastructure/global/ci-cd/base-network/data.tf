data "terraform_remote_state" "repo_connection" {
  backend = "s3"
  config = {
    bucket       = "terraform-backend-89972986"
    key          = "ci-cd/repo-connection/terraform.tfstate"
    region       = "ap-southeast-1"
    profile      = "plasabas-general-admin"
    use_lockfile = true
  }
}