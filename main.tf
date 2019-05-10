provider "kubernetes" {
  version = "~> 1.6"
}

resource "kubernetes_namespace" "demo" {
  count = var.namespace == "default" || var.namespace == "kube-system" ? 0 : 1
  metadata {
    name = var.namespace
  }
}

module "nginx" {
  source = "./deployment"
  namespace = var.namespace
  name = "nginx"
  containers = [
    {
      name = "nginx"
      image = "nginxinc/nginx-unprivileged:1.16"
      port = 8080
    }
  ]
}

module "zookeeper" {
  source = "./zookeeper"
  name = "zk"
  image = "k8s.gcr.io/kubernetes-zookeeper:1.0-3.4.10"
  namespace = var.namespace
}