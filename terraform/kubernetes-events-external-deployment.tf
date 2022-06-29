resource "kubernetes_deployment" "demo-node-external-deployment" {
  metadata {
    name = "demo-node-external-deployment"
    labels = {
      App = "demo-node-external"
    }
    namespace = kubernetes_namespace.demo-node_ns.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 90
    selector {
      match_labels = {
        App = "demo-node-external"
      }
    }
    template {
      metadata {
        labels = {
          App = "demo-node-external"
        }
      }
      spec {
        container {
          image = "${var.container_registry}/${var.external_image_name}"
          name  = "demo-node-external"

          env {
            name  = "SERVER"
            value = "http://demo-node-internal-service:8082"
          }
          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}
