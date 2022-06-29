resource "kubernetes_service" "demo-node-internal-service" {
  metadata {
    name      = "demo-node-internal-service"
    namespace = kubernetes_namespace.demo-node_ns.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.demo-node-internal-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8082
      target_port = 8082
    }

    type = "ClusterIP"
  }
}
