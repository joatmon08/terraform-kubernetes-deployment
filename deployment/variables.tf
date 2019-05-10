variable "namespace" {
  default = null
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