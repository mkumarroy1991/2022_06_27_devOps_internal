resource "kubernetes_service" "demo-node-external-service" {
  metadata {
    name      = "demo-node-external-service"
    namespace = kubernetes_namespace.demo-node_ns.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.demo-node-external-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.demo-node-external-service.status.0.load_balancer.0.ingress.0.ip
}
output "lb_status" {
  value = kubernetes_service.demo-node-external-service.status
}
