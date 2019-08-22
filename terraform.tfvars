namespace = "default"

name = "nginx"

containers = [
  {
    name  = "nginx"
    image = "nginxinc/nginx-unprivileged:1.16"
    port  = 8080
  },
]

enable_module = {
  zookeeper   = false
  helm_consul = false
}
