# Deployment - slo-orchestrator

**Use case:** Sre Analysts coordinate correlate traces to deploys for Grafana dashboards, so duplicate alerts collapse into actionable incidents.

## Infra requirements
→ `terraform/INFRA_REQUIREMENTS.md` - CPU/RAM/storage/network/cost breakdown

## GitOps
Flux watches `main` and reconciles changes automatically.

## Rollback
```
./scripts/rollback.sh
kubectl rollout undo deploy/slo-orchestrator -n slo-orchestrator
```
Usually < 30 sec.

## Cost
Fly.io - $0/mo

The observability stack itself is hardened so monitoring remains available during incidents.
