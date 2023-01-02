data "aws_kms_secrets" "credenciales" {
   secret {
      name = "cred"
      payload = file("credenciales.txt.encrypted")
   }
}

locals {
   cred = yamldecode(data.aws_kms_secrets.credenciales.plaintext["cred"])
}

output "cred" {
   value = local.cred
   description = "Credenciales"
   sensitive = true
}
