resource "kubernetes_service" "demo" {
  metadata {
    name = var.name
    namespace = var.namespace
    labels = {
      app = var.name
      }
  }

  spec {
    selector = {
      app = var.name
    }

    port {
      port = var.service_port
      target_port = var.containers[0].port
    }
  }
}