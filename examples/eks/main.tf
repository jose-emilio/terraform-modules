provider "aws" {
   region = "eu-west-1"
}

module "eks_cluster" {
   source = "../../terraform-modules/eks"
   name = "ejemplo-eks-cluster"
   min_size = 2
   max_size = 3
   desired_size = 2
   instance_types = ["t3.small"]
}

provider "kubernetes" {
   host = module.eks_cluster.cluster_endpoint
   cluster_ca_certificate = base64decode(
      module.eks_cluster.cluster_certificate_authority[0].data
   )
   token = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
   name = module.eks_cluster.cluster_name
}

module "simple_webapp" {
   source = "../../../k8s/modules/sample-app"
   name = "app-simple"
   image = "training/webapp"
   replicas = 4
   container_port = 5000
   environment_variables = {
      PROVIDER = "Teachers"
   }
   depends_on = [module.eks_cluster]
}

output "service_endpoint" {
   value = module.simple_webapp.service_endpoint
   description = "The K8s Service endpoint"
}
