resource "kubernetes_namespace" "demo-node_ns" {
  metadata {
    name = "demo"
  }
}