data "aws_ami" "amazon-linux" {
   most_recent = true
   owners = ["amazon"]
   filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-gp2"]
   }
   filter {
      name = "virtualization-type"
      values = ["hvm"]
   }
   filter {
      name = "root-device-type"
      values = ["ebs"]
   }
   filter {
      name = "architecture"
      values = [var.arquitectura.arch]
   }
}
resource "aws_launch_template" "plantilla" {
   name = "${var.nombre}-Plantilla-Lanzamiento"

   block_device_mappings {
     device_name = "/dev/sda1"
     ebs {
      volume_size = var.volumen 
      volume_type = "gp3"
     }
   }

   iam_instance_profile {
     name = var.perfil-instancia 
   }

   image_id = data.aws_ami.amazon-linux.id
   instance_type = var.arquitectura.tipo-instancia 
   user_data = filebase64(var.user-data)
   vpc_security_group_ids = [aws_security_group.ec2-sg.id]
}

resource "aws_autoscaling_group" "mi-asg" {
    name = "${var.nombre}-grupo-autoescalado"
    max_size = var.maxsize
    min_size = var.minsize
    desired_capacity = var.capacidad-deseada
    launch_template {
        id = aws_launch_template.plantilla.id
        version = "$Latest"
    }
    vpc_zone_identifier = var.subredes-ec2
    target_group_arns = [aws_lb_target_group.mi-alb-tg.arn]
    health_check_type = "ELB"
}

resource "aws_lb" "mi-alb" {
    name = "${var.nombre}-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb-sg.id]
    subnets = var.subredes-alb
}

resource "aws_lb_target_group" "mi-alb-tg" {
    name = "${var.nombre}-alb-tg"
    port = local.http-port 
    protocol = "HTTP"
    vpc_id = var.vpc 
}

resource "aws_lb_listener" "mi-alb-listener" {
    load_balancer_arn = aws_lb.mi-alb.arn
    port = local.http-port 
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.mi-alb-tg.arn
    }
}
