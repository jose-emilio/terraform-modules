output "ssm-role" {
   value = aws_iam_role.ssm-role.arn
   description = "ARN del rol con permisos sobre SSM para Amazon EC2"
}
