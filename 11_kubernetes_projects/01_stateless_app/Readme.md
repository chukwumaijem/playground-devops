### Project 1 — Deploy Your First Stateless App

**Complexity: ★☆☆☆☆ | Pure K8s**

#### Design Brief

The goal here is simple: get comfortable with the most fundamental unit of work in Kubernetes. You'll manually write a `Deployment` manifest to run a lightweight web server, then expose it inside the cluster using a `Service`. This teaches you the relationship between Pods, ReplicaSets, and Deployments, and why you almost never create Pods directly.

#### What to Build

Deploy a single Nginx web server with 2 replicas. Expose it via a `ClusterIP` Service. Exec into one pod and curl the Service's ClusterIP to prove traffic is routing correctly.

#### Key Concepts to Internalize

Think about this: if you delete one of the Pods manually, what happens? Watch it — that moment when Kubernetes recreates it is the ReplicaSet controller doing its job. That's the reconciliation loop in action.

#### Docker Images

- `nginx:1.25-alpine`

#### Deliverables

A `deployment.yaml` and `service.yaml`. Verify with `kubectl get pods`, `kubectl describe svc`, and a curl from inside the cluster.
