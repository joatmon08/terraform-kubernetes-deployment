resource "kubernetes_namespace" "example" {
  count = var.namespace == "default" || var.namespace == "kube-system" || var.namespace == null ? 0 : 1
  metadata {
    name = var.namespace
  }
}
