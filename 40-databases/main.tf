resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id
  tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-mongodb"
        }
  )
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  # Step 1: Copy local file to remote EC2
  provisioner "file" {
    source      = "bootstrap.sh"          # local file path
    destination = "/tmp/bootstrap.sh"  # remote path
  }
     connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }
  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb dev"

     ]
  }
}



# resource "aws_instance" "redis" {
#   ami           = local.ami_id
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [local.redis_sg_id]
#   subnet_id = local.database_subnet_id
#   tags = merge(
#         local.common_tags,
#         {
#             Name = "${local.common_name}-redis"
#         }
#   )
# }

# resource "terraform_data" "redis" {
#   triggers_replace = [
#     aws_instance.redis.id
#   ]

#   # Step 1: Copy local file to remote EC2
#   provisioner "file" {
#     source      = "bootstrap.sh"          # local file path
#     destination = "/tmp/bootstrap.sh"  # remote path
#   }
#      connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.redis.private_ip
#   }
#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/bootstrap.sh",
#         "sudo sh /tmp/bootstrap.sh redis dev"

#      ]
#   }
# }


# resource "aws_instance" "rabbitmq" {
#   ami           = local.ami_id
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [local.rabbitmq_sg_id]
#   subnet_id = local.database_subnet_id
#   tags = merge(
#         local.common_tags,
#         {
#             Name = "${local.common_name}-rabbitmq"
#         }
#   )
# }

# resource "terraform_data" "rabbitmq" {
#   triggers_replace = [
#     aws_instance.rabbitmq.id
#   ]

#   # Step 1: Copy local file to remote EC2
#   provisioner "file" {
#     source      = "bootstrap.sh"          # local file path
#     destination = "/tmp/bootstrap.sh"  # remote path
#   }
#      connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.rabbitmq.private_ip
#   }
#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/bootstrap.sh",
#         "sudo sh /tmp/bootstrap.sh rabbitmq dev"

#      ]
#   }
# }


# resource "aws_instance" "mysql" {
#   ami           = local.ami_id
#   instance_type = "t3.micro"
#   vpc_security_group_ids = [local.mysql_sg_id]
#   subnet_id = local.database_subnet_id
#   iam_instance_profile = aws_iam_instance_profile.mysql.name
#   tags = merge(
#         local.common_tags,
#         {
#             Name = "${local.common_name}-mysql"
#         }
#   )
# }

# resource "terraform_data" "mysql" {
#   triggers_replace = [
#     aws_instance.mysql.id
#   ]

#   # Step 1: Copy local file to remote EC2
#   provisioner "file" {
#     source      = "bootstrap.sh"          # local file path
#     destination = "/tmp/bootstrap.sh"  # remote path
#   }
#      connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.mysql.private_ip
#   }
#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/bootstrap.sh",
#         "sudo sh /tmp/bootstrap.sh mysql dev"

#      ]
#   }
# }

#Create Instance Profile (bridge between EC2 and IAM role)
# resource "aws_iam_instance_profile" "mysql" {
#   name = "mysql"
#   role = "EC2SSMParameterRead"
# }
