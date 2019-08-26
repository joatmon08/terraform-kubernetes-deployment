variable "namespace" {
  default = null
  description = "A kubernetes namespace to deploy to, default is default"
}

variable "name" {
  type = string
  description = "A name for the kubernetes deployment"
}

variable "user_id" {
  default = 1001
  description = "A user id for unprivileged containers, default is 1001"
}

variable "replicas" {
  default = 1
  description = "A number of replicas for the deployment, default is 1"
}

variable "service_port" {
  default = 80
  description = "A service port for a Kubernetes service, default is 80"
}

variable "containers" {
  type = list(object({
    name  = string,
    image = string,
    port  = number
  }))
  description = "A list of container objects, including name, image, and port to create"
}
