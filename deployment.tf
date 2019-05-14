resource "kubernetes_deployment" "example" {
  metadata {
    name = var.name
    namespace = var.namespace
    labels = {
      app = var.name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
            app = var.name
        }
      }

      spec {
        security_context {
          run_as_user = var.user_id
        }

        dynamic "container" {
          for_each = var.containers
          content {
            name = container.value.name
            image = container.value.image
            port {
              container_port = container.value.port
            }
            security_context {
              allow_privilege_escalation = false
            }
          }
        }
      }
    }
  }
}