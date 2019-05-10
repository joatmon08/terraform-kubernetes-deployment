provider "kubernetes" {
  version = "~> 1.6"
}

module "nginx" {
  source = "./deployment"
  app = {
    name = "nginx"
    image = "nginxinc/nginx-unprivileged:1.16"
    port = 8080
  }
}

module "zookeeper" {
  source = "./zookeeper"
  name = "zk"
  image = "k8s.gcr.io/kubernetes-zookeeper:1.0-3.4.10"
}