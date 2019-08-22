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

