#backend load balancer SG accepting the traffic from bastion SG
resource "aws_security_group_rule" "backend_LB_bastion" {
  type              = "ingress"
  security_group_id = local.backend_LB_sg_id #which SG we are applying
  source_security_group_id = local.bastion_sg_id # Attaching security from source
  from_port         = 80
  to_port           = 80
  protocol          = "tcp" # allowing port no 80
}

#bastion SG accepting traffic from laptop so ssh
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  security_group_id = local.bastion_sg_id #which SG we are applying
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" # allowing port no 80 
}

#mongodb SG accepting traffic from bastion
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id #which SG we are applying
  source_security_group_id = local.bastion_sg_id # Attaching security from source
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp" # allowing port no 27017
}