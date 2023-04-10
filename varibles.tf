variable "ami" {
  type    = string
  default = "ami-07d3a50bd29811cd1"
}
variable "keyname" {
  default = "terraform-workshop-vm"
  type    = string
}
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "default region"
}

variable "vpc_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = "default vpc_cidr_block"
}

variable "pub_sub1_cidr_block" {
  type    = string
  default = "172.16.1.0/24"
}

variable "pub_sub2_cidr_block" {
  type    = string
  default = "172.16.2.0/24"
}
variable "prv_sub1_cidr_block" {
  type    = string
  default = "172.16.3.0/24"
}
variable "prv_sub2_cidr_block" {
  type    = string
  default = "172.16.4.0/24"
}


variable "sg_name" {
  type    = string
  default = "alb_sg_tho_level_1"
}

variable "sg_description" {
  type    = string
  default = "SG for application load balancer"
}

variable "sg_tagname" {
  type    = string
  default = "SG for ALB"
}

variable "sg_ws_name" {
  type    = string
  default = "webserver_sg_tho_level1"
}

variable "sg_ws_description" {
  type    = string
  default = "SG for web server"
}

variable "sg_ws_tagname" {
  type    = string
  default = "SG for web"
}

variable "resource_tag_name" {
  type    = string
  default = "rds-tho-test"
}

variable "rds_identifier" {
  type    = string
  default = "postgres"
}

variable "rds_engine" {
  type    = string
  default = "postgres"
}

variable "rds_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "rds_engine_version" {
  type    = string
  default = "12.10"
}

variable "rds_allocated_storage" {
  default = 10
  type    = number
}

variable "rds_storage_encrypted" {
  default = true
  type    = bool
}


variable "rds_name" {
  type    = string
  default = "postgrestholevel"
}

variable "rds_username" {
  type    = string
  default = "postgres"
}

variable "rds_storage_type" {
  type    = string
  default = "gp2"
}

variable "rds_port" {
  default = 5432
  type    = number
}

variable "publicly_accessible" {
  default = false
  type    = bool
}

variable "skip_final_snapshot" {
  default = false
  type    = bool
}