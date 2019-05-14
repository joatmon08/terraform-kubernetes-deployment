resource "kubernetes_service" "zk_headless" {
  count = var.enable

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
      port = var.ports.server.port
      name = var.ports.server.name
    }

    port {
      port = var.ports.leader_election.port
      name = var.ports.leader_election.name
    }
  }
}

resource "kubernetes_service" "zk_client" {
  count = var.enable

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
      port = var.ports.client.port
      name = var.ports.client.name
    }
  }
}