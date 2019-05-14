terraform {
  required_version = ">=0.12"
}

provider "kubernetes" {
  version = "~> 1.6"
}

provider "helm" {
  version = "~> 0.9"
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

module "zookeeper" {
  source = "./zookeeper"
  name = "zk"
  image = "k8s.gcr.io/kubernetes-zookeeper:1.0-3.4.10"
  namespace = var.namespace
}

module "helm-consul" {
  source = "./helm-consul"
  name = "consul"
  namespace = var.namespace
}