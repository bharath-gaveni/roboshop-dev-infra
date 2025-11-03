locals {
    common_name = "${var.project_name}-${var.environment}"
    backend_LB_sg_id = data.aws_ssm_parameter.backend_LB_sg_id.value
    #private_subnet_ids = split("," , data.aws_ssm_parameter.private_subnet_ids.value)
    common_tags = {
        Project = "roboshop"
        Environment = "dev"
        Terraform = "true"
    }
}