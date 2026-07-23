# Setup - slo-orchestrator

Sre Analysts coordinate correlate traces to deploys for Grafana dashboards, so duplicate alerts collapse into actionable incidents.

1. **Infra first**: `cd terraform && terraform init && terraform apply`
2. `kubectl apply -k k8s/ -n slo-orchestrator`
3. `kubectl port-forward svc/slo-orchestrator 8080:80 -n slo-orchestrator`
4. `curl localhost:8080/healthz`

Env vars: `PORT=8080`, `LOG_LEVEL=info`

Dashboards and alerts are built around signal quality, not noise, with clear paging criteria.
