# Virtual Private Gateway (VGW)
resource "aws_vpn_gateway" "vgw" {
  vpc_id = data.terraform_remote_state.base_network.outputs.vpc_id
  tags   = { Name = "vpn-lab-vgw" }
}
