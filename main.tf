resource "random_string" "password" {
  length  = 32
  upper   = true
  numeric = true
  special = false
}

# Creating a AWS secret for database master account (Masteraccoundb)

resource "aws_secretsmanager_secret" "secretmasterDB" {
  name = "Masteraccoundb"
}

# Creating a AWS secret versions for database master account (Masteraccoundb)

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = <<EOF
   {
    "username": "${var.rds_username}",
    "password": "${random_string.password.result}"
   }
EOF
}

# Importing the AWS secrets created previously using arn.

data "aws_secretsmanager_secret" "secretmasterDB" {
  arn = aws_secretsmanager_secret.secretmasterDB.arn
}

# Importing the AWS secret version created previously using arn.

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.secretmasterDB.arn
}

# Create security group for load balancer

resource "aws_security_group" "elb_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["223.190.90.195/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow access from alb to internet"
  }

  tags = {
    Name    = var.sg_tagname
    Project = "demo-assignment"
  }
}

# Create security group for webserver

resource "aws_security_group" "webserver_sg" {
  name        = var.sg_ws_name
  description = var.sg_ws_description
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = [var.pub_sub1_cidr_block, var.pub_sub2_cidr_block]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    #tfsec:ignore:aws-ec2-no-public-egress-sgr
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow access from ec2 instance to internet"
  }
  tags = {
    Name    = var.sg_ws_tagname
    Project = "demo-assignment-tho-level-1"
  }
}

resource "aws_key_pair" "terraform-workshop-vm" {
  key_name   = var.keyname
  public_key = file("${path.root}/${var.keyname}.pub")
}

#Create Launch config

resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix     = "webserver-launch-config-tho-level-1"
  image_id        = var.ami
  instance_type   = "t2.2xlarge"
  key_name        = aws_key_pair.terraform-workshop-vm.key_name
  security_groups = [aws_security_group.webserver_sg.id]
  metadata_options {
    http_tokens = "required"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }


  lifecycle {
    ignore_changes        = [metadata_options]
    create_before_destroy = true
  }
  user_data = filebase64("${path.module}/init_webserver.sh")
}


# Create Auto Scaling Group
resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name                 = "Demo-ASG-tf-tho-level-1"
  desired_capacity     = 2
  max_size             = 2
  min_size             = 2
  force_delete         = true
  depends_on           = [aws_lb.ALB-tf]
  target_group_arns    = ["${aws_lb_target_group.TG-tf.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier  = [aws_subnet.prv_sub1.id, aws_subnet.prv_sub2.id]

  tag {
    key                 = "Name"
    value               = "Demo-ASG-tf-tho-level-1"
    propagate_at_launch = true
  }
}

# Create Target group

resource "aws_lb_target_group" "TG-tf" {
  name       = "Demo-TargetGroup-tf-tho-level-1"
  depends_on = [aws_vpc.main]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.main.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

resource "aws_lb" "ALB-tf" {
  name = "Demo-ALG-tf-tho-level-1"
  #tfsec:ignore:aws-elb-alb-not-public
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.elb_sg.id]
  subnets                    = [aws_subnet.pub_sub1.id, aws_subnet.pub_sub2.id]
  drop_invalid_header_fields = true
  tags = {
    Name    = "Demo-AppLoadBalancer-tf-tho-level-1"
    Project = "demo-assignment-tho-level-1"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  #tfsec:ignore:aws-elb-http-not-used
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf.arn
  }
}
