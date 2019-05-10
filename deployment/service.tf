resource "kubernetes_service" "demo" {
  metadata {
    name = var.app.name
    namespace = var.namespace
    labels = {
      app = var.app.name
      }
  }

  spec {
    selector = {
      app = var.app.name
    }

    port {
      port = var.service_port
      target_port = var.app.port
    }
  }
}