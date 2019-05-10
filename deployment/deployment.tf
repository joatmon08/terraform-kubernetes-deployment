resource "kubernetes_deployment" "demo" {
  metadata {
    name = var.app.name
    namespace = var.namespace
    labels = {
      app = var.app.name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.app.name
      }
    }

    template {
      metadata {
        labels = {
            app = var.app.name
        }
      }

      spec {
        container {
          name = var.app.name
          image = var.app.image
          port {
            container_port = var.app.port
          }
        }
      }
    }
  }
}