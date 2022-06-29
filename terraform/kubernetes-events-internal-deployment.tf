resource "kubernetes_deployment" "demo-node-internal-deployment" {
  metadata {
    name = "demo-node-internal-deployment"
    labels = {
      App = "demo-node-internal"
    }
    namespace = kubernetes_namespace.demo-node_ns.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "demo-node-internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "demo-node-internal"
        }
      }
      spec {
        container {
          image = "${var.container_registry}/${var.internal_image_name}"
          name  = "demo-node-internal"

          env {
            name  = "GOOGLE_CLOUD_PROJECT"
            value = var.project_id
          }
          env {
            name  = "PORT"
            value = 8082
          }
          port {
            container_port = 8082
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
