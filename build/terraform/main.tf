module "vpc" {
  source = "./modules/vpc"
  azs    = var.TF_VAR_azs
}

module "iam-roles" {
  source = "./modules/iam-roles"
}

module "lambda" {
  source      = "./modules/lambda"
  lambda_iam  = module.iam-roles.lambda_role_arn
  sg_outbound = module.security-groups.sg_ado_outbound
  subnet_ids  = [module.vpc.subnet_id]
  depends_on  = [module.iam-roles]
}


module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = module.vpc.vpc_id
}
