# slo-orchestrator
# Sre Analysts coordinate correlate traces to deploys for Grafana dashboards, so duplicate alerts collapse into actionable incidents.
#
# INFRASTRUCTURE REQUIREMENTS
# Kubernetes 1 x 2vCPU / 4GB
# CPU: 50m / 200m, MEM: 64Mi / 256Mi
# - Prometheus: 10GB PVC
# - Loki: 10GB PVC
# - Grafana: 1GB PVC
# Dependencies: - Prometheus
# - Grafana
# - Loki
# - Tempo
# - OpenTelemetry
# Cost: **$0/month** on Oracle Always Free / Fly.io

resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
    labels = { "app" = "slo-orchestrator", "managed-by" = "terraform" }
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name = "slo-orchestrator"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    replicas = var.replicas
    selector { match_labels = { app = "slo-orchestrator" } }
    template {
      metadata { labels = { app = "slo-orchestrator" } }
      spec {
        container {
          image = var.image
          name  = "app"
          port { container_port = 8080 }
          resources {
            requests = { cpu = "50m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "256Mi" }
          }
          liveness_probe {
            http_get { path = "/healthz" port = 8080 }
            initial_delay_seconds = 5
          }
          readiness_probe {
            http_get { path = "/readyz" port = 8080 }
            initial_delay_seconds = 3
          }
          security_context {
            run_as_non_root = true
            run_as_user = 10001
            allow_privilege_escalation = false
            read_only_root_filesystem = true
          }
        }
        security_context { fs_group = 10001 }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "slo-orchestrator"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    selector = { app = "slo-orchestrator" }
    port {
      port = 80
      target_port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "app" {
  metadata {
    name = "slo-orchestrator"
    namespace = kubernetes_namespace.app.metadata[0].name
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind = "Deployment"
      name = kubernetes_deployment.app.metadata[0].name
    }
    min_replicas = 2
    max_replicas = 10
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type = "AverageUtilization"
          average_utilization = 70
        }
      }
    }
  }
}
