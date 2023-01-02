terraform {
   backend "s3" {
      bucket = "terraform-state-tetuan"
      key = "global/iam/ºterraform.tfstate"
      region = "us-east-1"

      dynamodb_table = "terraform-locks"
      encrypt = true
   }
}

module "managed-policies" {
  source = "yukihira1992/managed-policies/aws"
}

data "aws_iam_policy" "ssmPolicy" {
  arn = module.managed-policies.AmazonSSMManagedInstanceCore
}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
   name = "SSMInstanceProfileForEC2"
   role = "${aws_iam_role.ssm-role.name}"
}

resource "aws_iam_role" "ssm-role" {
   name = "SSMRoleForEC2"
   assume_role_policy = jsonencode ({
      Version = "2012-10-17"
      Statement = [
         {
            Action = ["sts:AssumeRole"]
            Effect = "Allow"
            Principal = {
               Service = "ec2.amazonaws.com"
            }
         }
      ]
   })
   managed_policy_arns = [data.aws_iam_policy.ssmPolicy.arn]
}

