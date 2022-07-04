provider "aws" {
  region = "eu-west-1"
}

# VPC
resource "aws_vpc" "eng114_akshay_terraform_vpc" {
  cidr_block           = "10.40.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "eng114_akshay_terraform_vpc"
  }
}

# Subnets

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "eng114_akshay_terraform_ig" {
  vpc_id = aws_vpc.eng114_akshay_terraform_vpc.id
  tags = {
    Name = "eng114_akshay_terraform_ig"
  }
}

# Public subnet
resource "aws_subnet" "eng114_akshay_terraform_public_subnet" {
  vpc_id                  = aws_vpc.eng114_akshay_terraform_vpc.id
  cidr_block              = "10.40.102.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
    Name = "eng114_akshay_terraform_public_subnet"
  }
}

# Private Subnet
resource "aws_subnet" "eng114_akshay_terraform_private_subnet" {
  vpc_id                  = aws_vpc.eng114_akshay_terraform_vpc.id
  cidr_block              = "10.40.113.0/24"
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"
  tags = {
    Name = "eng114_akshay_terraform_private_subnet"
  }
}

# Route table (public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eng114_akshay_terraform_vpc.id
  tags = {
    Name = "eng114_akshay_terraform_public_route_table"
  }
}

# Route from (public)
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eng114_akshay_terraform_ig.id
}

# Subnet assosiations (public)
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.eng114_akshay_terraform_public_subnet.id
  route_table_id = aws_route_table.public.id
} 

# Subnet assosiations (private)
#resource "aws_route_table_association" "private" {
#  subnet_id      = aws_subnet.eng114_akshay_terraform_private_subnet.id
#  route_table_id = aws_route_table.public.id
#}

# sec groups
resource "aws_security_group" "eng114_akshay_terraform_sg_app"{
	name = "eng114_akshay_terraform_sg_app"
	vpc_id = aws_vpc.eng114_akshay_terraform_vpc.id

	ingress {
		description = "Allow NGINX"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "HTTPS from all"
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "SSH from local host"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"] # should be your own IP, this is for testing purposes only
	}

  ingress {
      description = "Allow access to port 3000"
      from_port =  3000
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
	description = "All traffic out"
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}

  tags = {
    Name        = "eng114_akshay_terraform_sg_app"
  }

}

resource "aws_security_group" "eng114_akshay_terraform_sg_db"{
	name = "eng114_akshay_terraform_sg_db"
	description = "Allow traffic on port 27017 for mongoDB"
	vpc_id = aws_vpc.eng114_akshay_terraform_vpc.id

	ingress {
		description = "SSH from local host"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"] # should be your own IP, this is for testing purposes only
	}

	ingress {
		description = "27017 from app instance"
		from_port = 27017
		to_port = 27017
		protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		description = "All traffic out"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

  tags = {
    Name        = "eng114_akshay_terraform_sg_db"
  }

}

resource "aws_security_group" "eng114_akshay_terraform_sg_controller"{
	name = "eng114_akshay_terraform_sg_controller"
	description = "Security group for controller"
	vpc_id = aws_vpc.eng114_akshay_terraform_vpc.id

  ingress {
	  description = "SSH from local host"
	  from_port = 22
	  to_port = 22
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"] # should be your own IP, this is for testing purposes only
	}

	egress {
		description = "All traffic out"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
# Routing tables to route traffic for Private Subnet
#resource "aws_route_table" "private" {
#  vpc_id = aws_vpc.vpc.id
#
#  tags = {
#    Name        = "${var.environment}-private-route-table"
#    Environment = "${var.environment}"
#  }
#}

# Routing tables to route traffic for Public Subnet
#resource "aws_route_table" "public" {
#  vpc_id = aws_vpc.vpc.id
#
#  tags = {
#    Name        = "${var.environment}-public-route-table"
#    Environment = "${var.environment}"
#  }
#}

# Route table associations for both Public & Private Subnets
#resource "aws_route_table_association" "public" {
#  count          = length(var.public_subnets_cidr)
#  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
#  route_table_id = aws_route_table.public.id
#}

#resource "aws_route_table_association" "private" {
#  count          = length(var.private_subnets_cidr)
#  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
#  route_table_id = aws_route_table.private.id
#}

resource "aws_instance" "app_instance"{
# choose your ami and instance type
        ami = var.app_ami
        instance_type = "t2.micro"
        key_name = var.key_name
    subnet_id = "${aws_subnet.eng114_akshay_terraform_public_subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.eng114_akshay_terraform_sg_app.id}"]


# enable a public ip
    associate_public_ip_address = true

# name the instance
    tags = {
        Name = "eng114_akshay_terraform_app"
    }
}

resource "aws_instance" "db_instance"{
#choose your ami and instance type
       ami = var.db_ami
       instance_type = "t2.micro"
       key_name = var.key_name
   subnet_id = "${aws_subnet.eng114_akshay_terraform_private_subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.eng114_akshay_terraform_sg_db.id}"]


#enable a public ip
   associate_public_ip_address = false

#name the instance
   tags = {
       Name = "eng114_akshay_terraform_db"
   }
}

resource "aws_instance" "controller"{
#choose your ami and instance type
       ami = var.controller_ami
       instance_type = "t2.micro"
       key_name = var.key_name
   subnet_id = "${aws_subnet.eng114_akshay_terraform_public_subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.eng114_akshay_terraform_sg_controller.id}"]


#enable a public ip
   associate_public_ip_address = true

#name the instance
   tags = {
       Name = "eng114_akshay_terraform_controller"
   }
}

# AUTO SCALING GROUPS NEEDS TO BE WORKED ON

# resource "aws_launch_template" "app_lt" {
#  name = "akshay_terraform_lt"
#  image_id = aws_instance.app_instance.ami
#  instance_type = "t2.micro"
#  vpc_security_group_ids = ["${aws_security_group.eng114_akshay_terraform_sg_app.id}"]
# }

# resource "aws_autoscaling_group" "bar" {
#  name = "eng114_akshay_terraform_app_asg"
#  min_size             = 1
#  max_size             = 3
#  desired_capacity     = 2
#  vpc_zone_identifier = [aws_subnet.public.id]
#  # launch_configuration = aws_launch_configuration.app_lt.name
#  # load_balancers  = [aws_lb.app-lb.id]
#  tag {
#    key = "Name"
#    propagate_at_launch = false
#    value = "eng114_akshay_app"
#  }
#  launch_template {
#    id = aws_launch_template.app_lt.id
#    version = "$Latest"
#  }
# }

################################################ Create load balancer (app)
# resource "aws_elb" "app_elb" {
#   name = "eng114_akshay_terraform-elb"
#   security_groups = ["${aws_security_group.app.id}"]
#   subnets = ["${aws_subnet.eng114_akshay_terraform_public_subnet.id}"]
#   cross_zone_load_balancing   = true
  
#   health_check {
#     healthy_threshold = 2
#     unhealthy_threshold = 2
#     timeout = 3
#     interval = 30
#     target = "HTTP:80/"
#   }
  
#   listener {
#     lb_port = 80
#     lb_protocol = "http"
#     instance_port = "80"
#     instance_protocol = "http"
#    }
#   }


# ##########################################################Create launch template
#   resource "aws_launch_configuration" "app" {
#   name_prefix = "eng114_akshay_terraform_ASG_app"
#   image_id = var.app_ami # ami of app instance
#   instance_type = "t2.micro"
#   key_name = var.key_name
#   security_groups = [ "${aws_security_group.app.id}" ]
#   associate_public_ip_address = true
  
#   lifecycle {
#     create_before_destroy = true
#   }
# }


# #############################################################Create auto scaling group
# resource "aws_autoscaling_group" "app" {
#   name = "${aws_launch_configuration.app.name}-asg"
#   min_size             = 2
#   desired_capacity     = 2
#   max_size             = 3
  

#   load_balancers = ["${aws_elb.app_elb.id}"]
#   launch_configuration = "${aws_launch_configuration.app.name}"
#   enabled_metrics = [
#     "GroupMinSize",
#     "GroupMaxSize",
#     "GroupDesiredCapacity",
#     "GroupInServiceInstances",
#     "GroupTotalInstances"
#   ]
#   metrics_granularity = "1Minute"
#   vpc_zone_identifier  = ["${aws_subnet.terraform_public_subnet.id}"]# Required to redeploy without an outage.
#   lifecycle {
#     create_before_destroy = true
#   }
#   tag {
#     key                 = "Name"
#     value               = "eng114-hamza-terraform-app-asg"
#     propagate_at_launch = true
#   }
  
#   }

