variable "region" {
  type    = string
  default = "us-east-1"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "5.7.37"
}

variable "multi_az" {
  type    = string
  default = "false"
}

variable "identifier" {
  type    = string
  default = "dev-rds-instance"
}

variable "username" {
  type    = string
  default = "sameer"
}

variable "password" {
  type    = string
  default = "sameer123"
}

variable "instance_class" {
  type    = string
  default = "db.t2.micro"
}

variable "allocated_storage" {
  type    = string
  default = 200
}

variable "db_name" {
  type    = string
  default = "applicationdb"
}

variable "skip_final_snapshot" {
  type    = string
  default = true
}
