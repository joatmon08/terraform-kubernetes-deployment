variable "enable" {
  default = false
}

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
    memory  = string,
    cpu     = string,
    storage = string
  })

  default = {
    memory  = "1Gi",
    cpu     = "0.5",
    storage = "10Gi"
  }
}

variable "ports" {
  type = object({
    server = object({
      name = string,
      port = number
    }),
    leader_election = object({
      name = string,
      port = number
    }),
    client = object({
      name = string,
      port = number
    })
  })

  default = {
    server = {
      name = "server",
      port = 2888
    },
    leader_election = {
      name = "leader-election",
      port = 3888
    },
    client = {
      name = "client",
      port = 2181
    }
  }
}