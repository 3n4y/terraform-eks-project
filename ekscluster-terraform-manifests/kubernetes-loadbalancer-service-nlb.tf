# Kubernetes Service Manifest (Type: Load Balancer)
resource "kubernetes_service_v1" "lb_service" {
  metadata {
    name = "testapp-lb-service-nlb"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb" # To create Network Load Balancer  
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.testapp.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = local.host_port
      target_port = local.container_port
    }
    type = "LoadBalancer"
  }
}




