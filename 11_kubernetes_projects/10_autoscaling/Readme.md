### Project 10 — Horizontal Pod Autoscaler (HPA) with Metrics Server

**Complexity: ★★★☆☆ | Pure K8s**

#### Design Brief

Manual scaling is fine for learning but production workloads need to scale automatically based on demand. The `HorizontalPodAutoscaler` watches metrics (CPU, memory, or custom) and adjusts replica counts. MicroK8s has the `metrics-server` addon — enable it for this project.

#### What to Build

Deploy a CPU-intensive app and configure an HPA targeting 50% CPU utilization, with a min of 2 and max of 10 replicas. Use a load generator to spike CPU and watch the HPA scale up. Then stop the load and observe the scale-down (note: scale-down has a deliberate cooldown period — why do you think that is?).

#### Docker Images

- `registry.k8s.io/hpa-example` — the canonical HPA demo image from the K8s docs. _(Note: previously `k8s.gcr.io` which is now deprecated — use the `registry.k8s.io` prefix.)_
- `busybox:1.36` — with a `wget` loop as your load generator.

#### Deliverables

Deployment, HPA manifest, and `kubectl get hpa --watch` output showing scale events.
