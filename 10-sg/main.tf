# module "catalogue" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "${local.common_name}-catalogue"
#   description = "Security group for user-service with custom ports open within VPC"
#   vpc_id      = data.aws_ssm_parameter.vpc_id.value
# }


module "sg" {
  source = "git::https://github.com/bharath-gaveni/terraform-aws-sg.git?ref=main"
  count = length(var.sg_names)
  sg_name = var.sg_names[count.index]
  vpc_id = local.vpc_id
  sg_description = "Created SG for ${var.sg_names[count.index]}"

}

# #frontend SG accepting the traffic from frontend load balancer SG
# resource "aws_security_group_rule" "frontend_frontend_LB" {
#   type              = "ingress"
#   security_group_id = module.sg[9].sg_id #which SG we are applying
#   source_security_group_id = module.sg[11].sg_id # Attaching security from source
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp" # allowing port no 80 for FALB
# }

