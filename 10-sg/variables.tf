variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "sg_names" {
    default = [
        # databases
        "mongodb","redis","mysql","rabbitmq",
         # backend
        "catalogue","user","cart","shipping","payment",
        # frontend
        "frontend",
        # bastion
        "bastion",
        # frontend LB
        "frontend_LB",
        # Backend_LB
        "backend_LB"
    ]
}
