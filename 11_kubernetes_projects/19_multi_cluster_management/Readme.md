### Project 19 — Multi-Cluster Management

**Complexity: ★★★★★ | Uses both your Proxmox clusters**

#### Design Brief

This is where your two MicroK8s clusters become genuinely useful together. You'll use your single-node cluster as "staging" and the multi-node as "production," managed from a single control point. This project is deliberately more open-ended — you'll need to research and decide on some of the tooling yourself.

#### What to Build

Configure `kubeconfig` to hold contexts for both clusters (explore `kubectx`/`kubens` as CLI helpers). Deploy the same Helm chart from Project 16 to both clusters with different values files. Use Argo CD's multi-cluster support to manage both from a single Argo instance running on one cluster. As a stretch goal, explore deploying a `ServiceExport`/`ServiceImport` pattern so a service in one cluster can be reached from the other.

#### Docker Images

Same as previous projects. The new tooling is CLI-based (`kubectx`, `kubens`) rather than container-based. Argo CD manages its own images.

#### Deliverables

A working multi-cluster kubeconfig, Argo CD configured with two cluster targets, and a write-up of the challenges and trade-offs you encountered.