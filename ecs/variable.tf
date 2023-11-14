variable "family" {
    default = "hybytes-task-definition"
}

variable "network_mode" {
    default = "awsvpc"
}

variable "image" {
    default = "759910503519.dkr.ecr.us-east-1.amazonaws.com/test-repo:latest"
}

variable "operating_system_family" {
    default = "LINUX"
}

variable "cpu_architecture" {
    default = "X86_64"
}

variable "subnets" {
    default = ["subnet-020b485fb7ba9c217", "subnet-0ad3bcadb86da23f5"]
}

variable "security_groups" {
    default = ["sg-0540fc6d85a5d6de6"]
}