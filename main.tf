provider "kubernetes" {
  version = "~> 1.6"
}

module "nginx_deployment" {
  source = "./deployment"
  app = {
    name = "nginx"
    image = "nginxinc/nginx-unprivileged:1.16"
    port = 8080
  }
}