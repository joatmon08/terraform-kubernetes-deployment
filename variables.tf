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
    zookeeper   = bool,
    helm_consul = bool
  })

  default = {
    zookeeper   = true,
    helm_consul = false
  }
}