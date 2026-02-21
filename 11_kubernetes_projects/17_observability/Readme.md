### Project 17 — Observability: Metrics, Logs, and Dashboards

**Complexity: ★★★★★ | Introduces: Prometheus, Grafana, Loki**

#### Design Brief

You can't operate what you can't observe. This project builds a full observability stack using the Prometheus/Grafana/Loki combination — the industry standard for Kubernetes monitoring. The goal is to understand _what_ is being collected and _why_, not just deploy the stack.

#### What to Build

Using the `kube-prometheus-stack` Helm chart from Project 16, deploy the full monitoring stack. Deploy `podinfo` as your monitored application — it exposes a `/metrics` endpoint out of the box. Create a `ServiceMonitor` CRD so Prometheus auto-discovers it. In Grafana, build a dashboard showing request rate, error rate, and latency (the RED method). Deploy Loki with Promtail as a DaemonSet to ship pod logs into Grafana.

#### Docker Images

- **Monitored application:** `stefanprodan/podinfo:6.5.3` — a Go microservice built for K8s demos with `/metrics`, `/healthz`, `/readyz`, configurable stress endpoints, and a clean UI. The de facto standard K8s demo app.
- **Loki (log aggregation):** `grafana/loki:2.9.0`
- **Promtail (log shipper):** `grafana/promtail:2.9.0`
- **Prometheus + Grafana:** Managed automatically by the `kube-prometheus-stack` Helm chart

#### Deliverables

Helm values files, a `ServiceMonitor` manifest, and an exported Grafana dashboard JSON.
