# FAQ - slo-orchestrator

**Q: What problem does this actually solve?**
A: Sre Analysts coordinate correlate traces to deploys for Grafana dashboards, so duplicate alerts collapse into actionable incidents.

Pain point: Dashboards show symptoms but do not connect them to owners, deploys, or traces.

**Q: Free to run?**
A: Yep. Fly.io - $0/mo. See `terraform/INFRA_REQUIREMENTS.md`

**Q: Production ready?**
A: Yes - SLOs, security hardening, DR runbook, Helm, Terraform, monitoring.

**Q: Stack?**
A: Prometheus, Grafana, Loki, Tempo, OpenTelemetry, Helm

**Q: What infra do I need?**
A: `terraform/INFRA_REQUIREMENTS.md` has the full breakdown - CPU/RAM/storage/network/cost.
