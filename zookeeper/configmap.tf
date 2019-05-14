resource "null_resource" "hosts" {
  count = var.replicas
 
  triggers = {
    zk_hosts = format("%s-%d:%d", var.name, count.index, var.ports.client.port)
  }
}

resource "kubernetes_config_map" "zk_connection_string" {
  metadata {
    name      = "${var.name}-connection-string"
    namespace = var.namespace
  }

  data = {
    hosts = join(",", null_resource.hosts.*.triggers.zk_hosts)
  }
}

