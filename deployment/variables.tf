variable "namespace" {
  default = null
}

variable "user_id" {
  default = 1001
}

variable "replicas" {
  default = 1
}

variable "service_port" {
  default = 80
}

variable "app" {
  type = object({
    name = string,
    image = string,
    port = number
  })
}