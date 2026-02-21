### Project 8 — DaemonSets and Node Affinity

**Complexity: ★★★☆☆ | Pure K8s**

#### Design Brief

Not all workloads are stateless web apps. `DaemonSet` is the right controller when you need exactly one pod per node — classic use cases are log collectors, monitoring agents, and network plugins. This project also introduces you to node selection with `nodeSelector` and the more expressive `affinity` / `taints and tolerations` system.

#### What to Build

Deploy a `DaemonSet` that runs a log collector on every node (you can simulate this with a pod that tails `/var/log/syslog`). Then label one of your nodes with `role=gpu` and deploy a second workload using `nodeAffinity` to ensure it _only_ runs on that node. Finally, apply a `taint` to a node and see that regular pods avoid it, then add a `toleration` to a specific deployment so it can land on the tainted node.

#### Docker Images

- `fluent/fluent-bit:2.1` — for the DaemonSet log collector.
- `busybox:1.36` — for the affinity and taint/toleration experiments.

#### Deliverables

DaemonSet manifest, affinity-constrained deployment, taint/toleration demo.
