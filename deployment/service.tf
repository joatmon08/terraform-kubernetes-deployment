resource "kubernetes_service" "example" {
    metadata {
        name = var.app.name
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