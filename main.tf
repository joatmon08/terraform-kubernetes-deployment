terraform {
  required_version = "~>0.12"

  backend "remote" {}
}

provider "kubernetes" {
  version = "~> 1.7"
}

provider "helm" {
  version = "~> 0.9"
  install_tiller = true
}

provider "null" {
  version = "~> 2.1"
}

resource "kubernetes_namespace" "example" {
  count = var.namespace == "default" || var.namespace == "kube-system" || var.namespace == null ? 0 : 1
  metadata {
    name = var.namespace
  }
}
