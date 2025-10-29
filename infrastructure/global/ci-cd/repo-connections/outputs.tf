output "github_id" {
  description = "GitHub Connection ID"
  value       = aws_codestarconnections_connection.this.id
}

output "github_arn" {
  description = "GitHub Connection ARN"
  value       = aws_codestarconnections_connection.this.arn
}