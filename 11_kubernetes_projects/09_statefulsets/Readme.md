### Project 9 — StatefulSets: Running a Replicated Database

**Complexity: ★★★☆☆ | Pure K8s**

#### Design Brief

`StatefulSet` is the controller for stateful workloads. Unlike Deployments, pods in a StatefulSet have stable network identities (`pod-0`, `pod-1`, ...) and stable storage (each pod gets its own PVC). This project gives you a concrete feel for _why_ that matters by running a multi-instance Redis setup where you can observe pod identity.

#### What to Build

Deploy a 3-replica Redis StatefulSet with a `volumeClaimTemplate` so each pod gets its own `1Gi` PVC. Deploy a `Headless Service` (ClusterIP: None) alongside it — this is what gives you stable DNS names like `redis-0.redis-svc`. From a test pod, connect to `redis-0.redis-svc` directly. Delete `redis-0` and observe that it comes back with the same identity and storage.

#### Docker Images

- `redis:7.2-alpine`

#### Deliverables

StatefulSet and Headless Service manifests. Show the stable DNS resolution and PVC persistence across pod deletion.
