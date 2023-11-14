variable "security_groups" {
  type    = list(string)
  default = ["sg-0540fc6d85a5d6de6"]
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-027351911fec71383", "subnet-0830047b77924385c"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-084177a0e0a8c7a6d"
}



