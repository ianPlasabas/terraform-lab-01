output "vpc_arn" {
  description = "VPC ARN from the vpc module"
  value       = module.vpc.vpc_arn
}

output "vpc_id" {
  description = "VPC ID from the vpc module"
  value       = module.vpc.vpc_id
}

output "igw_id" {
  description = "ID of Internet Gateway"
  value       = module.vpc.igw_id
}

output "igw_arn" {
  description = "ARN of Internet Gateway"
  value       = module.vpc.igw_arn
}

output "nat_id" {
  description = "ID of NAT Gateway"
  value       = module.vpc.nat_id
}

output "subnets_id" {
  description = "Web Subnet/s ID/s"
  value       = module.vpc.subnets_id
}

output "subnets_arn" {
  description = "Web Subnet/s ARN/s"
  value       = module.vpc.subnets_arn
}

output "web-rt-id" {
  description = "Web Route Table ID"
  value       = module.vpc.web-rt-id
}

output "web-rt-arn" {
  description = "Web Route Table ARN"
  value       = module.vpc.web-rt-arn
}

output "app-rt-id" {
  description = "Web Route Table/s ID/s"
  value       = module.vpc.app-rt-id
}

output "app-rt-arn" {
  description = "Web Route Table ARN"
  value       = module.vpc.app-rt-arn
}

output "db-rt-id" {
  description = "DB Route Table/s ID/s"
  value       = module.vpc.db-rt-arn
}

output "db-rt-arn" {
  description = "DB Route Table ARN"
  value       = module.vpc.db-rt-arn
}