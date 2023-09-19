# Kubernetes Deployment Manifest
resource "kubernetes_deployment_v1" "testapp" {
  metadata {
    name = "testapp-deployment"
    labels = {
      app = "testapp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "testapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "testapp"
        }
      }

      spec {
        container {
          image = "kodekloud/ecs-project1"
          name  = "test-app"
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

