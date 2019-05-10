resource "kubernetes_stateful_set" "zk" {
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

    service_name = kubernetes_service.zk_headless.metadata[0].name

    update_strategy {
      type = "RollingUpdate"
    }

    pod_management_policy = "OrderedReady"
    
    template {
      metadata {
        labels = {
            app = var.name
        }
      }

      spec {

        security_context {
          run_as_user = 1000
          fs_group = 1000
        }

        container {
          name = "zk"
          image_pull_policy = "Always"
          image = var.image
          resources {
            requests {
              memory = var.requests.memory
              cpu = var.requests.cpu
            }
          }
          port {
            container_port = var.ports.client
            name = "client"
          }
          port {
            container_port = var.ports.server
            name = "server"
          }
          port {
            container_port = var.ports.leader_election
            name = "leader-election"
          }
          command = [
            "sh",
            "-c",
            "start-zookeeper --servers=${var.replicas} --data_dir=/var/lib/zookeeper/data --data_log_dir=/var/lib/zookeeper/data/log --conf_dir=/opt/zookeeper/conf --client_port=${var.ports.client} --election_port=${var.ports.leader_election} --server_port=${var.ports.server} --tick_time=2000 --init_limit=10 --sync_limit=5 --heap=512M --max_client_cnxns=60 --snap_retain_count=3 --purge_interval=12 --max_session_timeout=40000 --min_session_timeout=4000 --log_level=INFO"
          ]
          readiness_probe {
            exec {
              command = [
                "sh",
                "-c",
                "zookeeper-ready ${var.ports.client}"
              ]
            }
            initial_delay_seconds = 10
            timeout_seconds = 5
          }
          liveness_probe {
            exec {
              command = [
                "sh",
                "-c",
                "zookeeper-ready ${var.ports.client}"
              ]
            }
            initial_delay_seconds = 10
            timeout_seconds = 5
          }
          volume_mount {
            name = "datadir"
            mount_path = "/var/lib/zookeeper"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "datadir"
      }
      spec {
        access_modes = ["ReadWriteOnce"]
        resources {
          requests = {
            storage = var.requests.storage
          }
        }
      }
    }
  }
}