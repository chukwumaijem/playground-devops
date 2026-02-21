### Project 14 — Network Policies: Zero-Trust Networking

**Complexity: ★★★★☆ | Pure K8s**

#### Design Brief

By default, every pod in Kubernetes can talk to every other pod — that's a security problem. `NetworkPolicy` lets you define explicit allow-lists for ingress and egress traffic. MicroK8s's default CNI supports NetworkPolicy. This project takes the three-tier app from Project 13 and locks it down.

#### What to Build

Starting from Project 13, apply NetworkPolicies so that: the vote frontend can only receive traffic from the Ingress controller, the worker can only communicate with Redis and PostgreSQL, the results frontend can only read from PostgreSQL, and PostgreSQL can only receive traffic from the worker and results service. Apply a default-deny policy first, then add rules incrementally.

#### Docker Images

Same as Project 13, plus:

- `nicolaka/netshoot:latest` — a network troubleshooting image packed with `curl`, `netcat`, `dig`, `nmap`, and `tcpdump`. Deploy this as a debug pod to probe connectivity between services and verify your NetworkPolicies are blocking what you expect. **This image should become a permanent fixture in your toolkit.**

#### Deliverables

A suite of NetworkPolicy manifests with a written explanation of each rule. Demonstrate that unauthorized pod-to-pod communication is blocked.
