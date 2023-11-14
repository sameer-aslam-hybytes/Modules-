#calling the alb module for ecs
module "alb" {
  source = "../alb"

}

resource "aws_ecs_cluster" "HB" {
  name = "hybytes"
}
resource "aws_ecs_cluster_capacity_providers" "hybytes-provider" {
  cluster_name = aws_ecs_cluster.HB.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

#create task definition to define container 
resource "aws_ecs_task_definition" "HB-def" {
  family                   = var.family
  requires_compatibilities = ["FARGATE"]
  network_mode             = var.network_mode
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::759910503519:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = var.image
      cpu       = 256
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }

  ])
  runtime_platform {
    operating_system_family = var.operating_system_family
    cpu_architecture        = var.cpu_architecture
  }
}

#create ecs service to run task definition
resource "aws_ecs_service" "HB-service" {
  name = "hybytes-service"
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  cluster             = aws_ecs_cluster.HB.id
  task_definition     = aws_ecs_task_definition.HB-def.arn
  scheduling_strategy = "REPLICA"
  desired_count       = 2
  launch_type         = "FARGATE"

  load_balancer {
    target_group_arn = module.alb.alb_target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
}

#calling vpc sources using data block
# data "aws_vpc" "vpc" {  
#   id = module.vpc.vpc_id
# }

# resource "aws_security_group" "vpc" {
#   name        = "example"
#   description = "Example Security Group"
#   vpc_id      = data.aws_vpc.example.id

#   # Add rules, etc.
# }

