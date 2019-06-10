resource "null_resource" "numbered_hosts" {
  count = var.enable ? var.replicas : 0

  triggers = {
    hosts = format("%s-%d", var.name, count.index)
  }
}

resource "kubernetes_config_map" "zk_config" {
  count = var.enable ? 1 : 0

  metadata {
    name      = "${var.name}-zoo-cfg"
    namespace = var.namespace
  }

  data = {
    config = <<EOT
tickTime=2000
dataDir=/var/zookeeper
clientPort=${var.ports.client.port}
initLimit=5
syncLimit=2
%{for i, host in null_resource.numbered_hosts.*.triggers.hosts~}
server.${i}=${host}:${var.ports.server.port}:${var.ports.leader_election.port}
%{endfor}
EOT
  }
}