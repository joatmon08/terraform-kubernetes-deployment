resource "kubernetes_service" "zk_headless" {
  metadata {
    name = "${var.name}-headless"
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
      port = var.ports.server
      name = "server"
    }

    port {
      port = var.ports.leader_election
      name = "leader-election"
    }
  }
}

resource "kubernetes_service" "zk_client" {
  metadata {
    name = "${var.name}-client"
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
      port = var.ports.client
      name = "client"
    }
  }
}