### Project 3 — Exposing Apps with NodePort and LoadBalancer Services

**Complexity: ★★☆☆☆ | Pure K8s**

#### Design Brief

In Project 1 you used `ClusterIP`, which is internal-only. Now you'll explore how to expose applications to the outside world. MicroK8s ships with MetalLB which you should enable — this lets you use `LoadBalancer` type Services on a bare-metal cluster, which is a very instructive experience because it demystifies what managed cloud Kubernetes does for you automatically.

#### What to Build

Deploy a small HTTP echo server with 3 replicas. First expose it with a `NodePort` Service and access it via `<node-ip>:<nodePort>`. Then change it to `LoadBalancer` type and observe the difference in how the IP is assigned.

#### Docker Images

- `hashicorp/http-echo:0.2.3` — pass `-text="hello from pod $(POD_NAME)"` as args, injecting `POD_NAME` via the Downward API so you can see which pod is serving each request.

#### Deliverables

Two service manifests (one NodePort, one LoadBalancer). A short observation of load balancing behavior using repeated curl calls.
