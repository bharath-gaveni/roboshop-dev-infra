resource "aws_lb" "backend_lb" {
  name               = "${local.common_name}-backend-lb" #roboshop-dev_backend_lb
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_LB_sg_id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = false

  tags =merge(
    local.common_tags,
    {
        Name = "${local.common_name}-backend-lb"
    }
  )
}

#listioning bastion constanly from backedn_lb (attached listner to backend_LB)
resource "aws_lb_listener" "bastion_backend_lb" {
  load_balancer_arn = aws_lb.backend_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi I am from Backend Load Balancer (as frontend server is not ready testing by uding you bastion)"
      status_code  = "200"
    }
  }
}