# Operations Runbook - slo-orchestrator

Sre Analysts coordinate correlate traces to deploys for Grafana dashboards, so duplicate alerts collapse into actionable incidents.

**On-call? Read this first.**

## Deploy
```
kubectl apply -k k8s/ -n slo-orchestrator
kubectl rollout status deploy/slo-orchestrator -n slo-orchestrator
```

## Rollback (when things go red)
```
./scripts/rollback.sh
# usually < 30sec
```

## Scale up NOW
```
kubectl scale deploy/slo-orchestrator --replicas=10 -n slo-orchestrator
```

## Logs
```
kubectl logs -l app=slo-orchestrator -n slo-orchestrator -f --tail=200
```

## Crashloop?
```
kubectl describe pod -l app=slo-orchestrator -n slo-orchestrator
kubectl logs <pod> --previous -n slo-orchestrator
```
90% of the time: missing env var in ConfigMap.

## Metrics
`curl localhost:8080/metrics` or Grafana dashboard in `monitoring/`

## DR / Failover
See `docs/DISASTER_RECOVERY.md` - RTO 15m

We actually tested this. 11 min.
