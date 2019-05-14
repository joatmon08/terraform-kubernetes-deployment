variable "namespace" {
  default = null
}

variable "name" {
  type = string
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

variable "containers" {
  type = list(object({
    name  = string,
    image = string,
    port  = number
  }))
}

variable "enable_module" {
  type = object({
    zookeeper   = number,
    helm_consul = number
  })

  default = {
    zookeeper   = 0,
    helm_consul = 0
  }
}