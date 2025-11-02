module "vpc" {
  source = "git::https://github.com/bharath-gaveni/terraform-aws-vpc.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  vpc_cidr = var.vpc_cidr
  public_subnets_cidrs = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  database_subnets_cidrs = var.database_subnets_cidrs

  #is_peering_required = false #if user not required peering 
}

