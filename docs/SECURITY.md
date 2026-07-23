# Security - slo-orchestrator

What we do:
- Trivy scan in CI - blocks HIGH/CRITICAL
- Cosign sign images
- Non-root UID 10001, readOnlyRootFilesystem
- NetworkPolicy default-deny
- RBAC least-privilege
- Secrets via External Secrets / Vault (not in git)
- Dependabot + CodeQL on

Threat model: Dashboards show symptoms but do not connect them to owners, deploys, or traces.

The observability stack itself is hardened so monitoring remains available during incidents.
