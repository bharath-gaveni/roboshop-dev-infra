resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subnet_id
  tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-catalogue"
        }
  )
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  # Step 1: Copy local file to remote EC2
  provisioner "file" {
    source      = "catalogue.sh"          # local file path
    destination = "/tmp/catalogue.sh"  # remote path
  }
     connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }
  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/catalogue.sh",
        "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
     ]
  }
}

#Stopped the instance to take AMI
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"   # other option: "running"
  depends_on = [ terraform_data.catalogue ]
}

#Take AMI from the Stopped instance
resource "aws_ami_from_instance" "catalogue" {
  name               = "roboshop-dev-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  tags = merge(
        local.common_tags,
        {
            Name = "${local.common_name}-catalogue-ami"
        }
  )
  depends_on = [ aws_ec2_instance_state.catalogue ]
}


resource "aws_route53_record" "catalogue" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 1
  records = [aws_instance.catalogue.private_ip]
  allow_overwrite = true
}