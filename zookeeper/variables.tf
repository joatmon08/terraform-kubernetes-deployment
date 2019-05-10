variable "namespace" {
  default = null
}

variable "replicas" {
  default = 3
}

variable "name" {}

variable "image" {}

variable "requests" {
  type = object({
    memory = string,
    cpu = string,
    storage = string
  })

  default = {
    memory = "1Gi",
    cpu = "0.5",
    storage = "10Gi"
  }
}

variable "ports" {
  type = object({
    server = number,
    leader_election = number,
    client = number
  })

  default = {
    server = 2888,
    leader_election = 3888,
    client = 2181
  }
}