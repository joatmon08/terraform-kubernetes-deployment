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
        security_context {
          run_as_user = var.user_id
        }

        container {
          name = var.app.name
          image = var.app.image
          port {
            container_port = var.app.port
          }
          security_context {
            allow_privilege_escalation = false
          }
        }
      }
    }
  }
}