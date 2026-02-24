# Kubernetes Learning Projects: A Progressive Curriculum

> A curated set of 20 projects designed to take you from core K8s fundamentals to complex, real-world architectures. Projects 1–10 focus purely on native Kubernetes concepts. Projects 11–20 layer in real-world patterns and introduce external tooling as complexity demands.

---

## Core Image Toolkit

Here's a summary of all the Docker images used across the curriculum, grouped by purpose:

**Utility images** (debugging, probing, scripting inside the cluster):

- `busybox:1.36`
- `nicolaka/netshoot:latest`
- `curlimages/curl:8.4.0`
- `bitnami/kubectl:latest`

**Demo application images** (carry the pedagogical weight):

- `dockersamples/examplevotingapp_vote:latest`
- `dockersamples/examplevotingapp_result:latest`
- `dockersamples/examplevotingapp_worker:latest`
- `stefanprodan/podinfo:6.5.3`
- `traefik/whoami:latest`
- `hashicorp/http-echo:0.2.3`
- `gcr.io/google-samples/microservices-demo/*:v0.10.1` (capstone)

**Infrastructure images** (configure rather than code):

- `nginx:1.25-alpine`
- `redis:7.2-alpine`
- `postgres:15-alpine`

---

## Part 1 — Pure Kubernetes (Projects 1–10)

> These projects use only native Kubernetes primitives — no Helm, no external operators. Complete these slowly. The concepts here are the foundation everything else builds on.

|     | #   | Project                                                                                |
| --- | --- | -------------------------------------------------------------------------------------- |
| [x] | 1   | [Deploy Your First Stateless App](01_stateless_app/Readme.md)                          |
| [ ] | 2   | [Configuration and Secrets Management](02_config_n_secrets/Readme.md)                  |
| [ ] | 3   | [Exposing Apps with NodePort and LoadBalancer Services](03_k8s_services/Readme.md)     |
| [ ] | 4   | [Persistent Storage with PVs and PVCs](04_k8s_volumes/Readme.md)                       |
| [ ] | 5   | [Health Checks: Liveness, Readiness, and Startup Probes](05_k8s_healthcheck/Readme.md) |
| [ ] | 6   | [Rolling Updates and Rollbacks](06_k8s_updates/Readme.md)                              |
| [ ] | 7   | [Namespaces, RBAC, and Service Accounts](07_namespaces_n_access_control/Readme.md)     |
| [ ] | 8   | [DaemonSets and Node Affinity](08_daemonset_n_node_affinity/Readme.md)                 |
| [ ] | 9   | [StatefulSets: Running a Replicated Database](09_statefulsets/Readme.md)               |
| [ ] | 10  | [Horizontal Pod Autoscaler (HPA) with Metrics Server](10_autoscaling/Readme.md)        |

## Part 2 — Real-World Patterns (Projects 11–20)

> These projects layer in external tooling and real-world architectures. Some projects are deliberately less prescriptive — figuring out the gaps is part of the learning.

|     | #   | Project                                                                          |
| --- | --- | -------------------------------------------------------------------------------- |
| [ ] | 11  | [Ingress Controller and Path-Based Routing](11_ingress_n_routing/Readme.md)      |
| [ ] | 12  | [TLS Termination and Certificate Management](12_tls_n_cert_management/Readme.md) |
| [ ] | 13  | [Multi-Tier Application: Web + API + Database](13_multi_tier_app/Readme.md)      |
| [ ] | 14  | [Network Policies: Zero-Trust Networking](14_network_policies/Readme.md)         |
| [ ] | 15  | [Jobs, CronJobs, and Init Containers](15_jobs_n_init_containers/Readme.md)       |
| [ ] | 16  | [Helm: Packaging and Deploying Applications](16_helm_package_n_deploy/Readme.md) |
| [ ] | 17  | [Observability: Metrics, Logs, and Dashboards](17_observability/Readme.md)       |
| [ ] | 18  | [GitOps with Argo CD](18_gitops/Readme.md)                                       |
| [ ] | 19  | [Multi-Cluster Management](19_multi_cluster_management/Readme.md)                |
| [ ] | 20  | [Capstone: Building a Production-Grade Platform](20_capstone/Readme.md)          |

## How to Approach This Curriculum

Think of Projects 1–5 as your foundation — do them slowly and don't move on until the concepts feel genuinely intuitive. Projects 6–10 build the operational vocabulary you need to understand _why_ Kubernetes works the way it does. Projects 11–15 push you into real architecture decisions. Projects 16–20 are where the learning shifts from "how does this work" to "how do I operate this responsibly."

### Diagnostic Habit

After each project, try to _break_ something deliberately — delete a pod, exhaust a PVC, trigger a probe failure — and then diagnose it using only:

- `kubectl describe <resource>`
- `kubectl get events`
- `kubectl logs <pod>`

That diagnostic muscle is what separates someone who has _learned_ Kubernetes from someone who can _work with it under pressure_.

### Keep a Learning Journal

Keep a running notes file as you go — not just "what I did" but "what surprised me." Kubernetes has many moments where the system behaves counterintuitively until you understand the underlying controller logic. Writing those moments down cements the mental model far better than re-reading documentation ever will.
