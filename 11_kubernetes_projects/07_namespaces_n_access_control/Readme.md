### Project 7 — Namespaces, RBAC, and Service Accounts

**Complexity: ★★★☆☆ | Pure K8s**

#### Design Brief

In a real cluster, multiple teams or applications share the same infrastructure. Namespaces provide logical isolation, while RBAC (Role-Based Access Control) controls who can do what. This project walks you through creating a restricted environment where a service account can only read pods in its own namespace — a common pattern for CI/CD agents and operators.

#### What to Build

Create two namespaces: `team-alpha` and `team-beta`. In `team-alpha`, create a ServiceAccount, a Role (allowing `get`, `list`, `watch` on pods only), and a RoleBinding. Deploy a pod using that ServiceAccount and use `kubectl auth can-i` from inside the pod (via the mounted token) to prove the restrictions work. Try to list pods in `team-beta` from within the `team-alpha` pod — it should be denied.

#### Docker Images

- `bitnami/kubectl:latest` — has kubectl pre-installed, making it easy to run kubectl commands from within a pod using the mounted ServiceAccount token.

#### Deliverables

All RBAC manifests plus a demo of permission boundaries being enforced.
