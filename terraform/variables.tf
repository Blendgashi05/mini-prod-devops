variable "app_version" {
  default = "v1"
}

variable "namespace" {
  default = "mini-prod"
}

variable "image_tag" {
  default = "latest"
}

variable "app_port" {
  default = 5000
}

variable "db_host" {
  default = "postgres"
}

variable "db_port" {
  default = 5432
}
