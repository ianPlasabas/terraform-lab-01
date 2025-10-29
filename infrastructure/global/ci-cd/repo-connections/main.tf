#=================================================
# GitHub Connection
#=================================================
resource "aws_codestarconnections_connection" "this" {
  name          = "github-connection"
  provider_type = "GitHub"
}
