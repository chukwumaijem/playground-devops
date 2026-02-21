### Project 11 — Ingress Controller and Path-Based Routing

**Complexity: ★★★☆☆ | Introduces: Ingress (MicroK8s addon)**

#### Design Brief

Up until now you've been using Services to expose apps. Ingress is the HTTP/S-aware layer that sits in front of your Services, giving you hostname-based and path-based routing from a single IP. MicroK8s includes the NGINX Ingress Controller as an addon. This is the first project where you lean on a bundled add-on, but it's worth understanding it as a concept deeply before moving to Helm-installed controllers.

#### What to Build

Deploy three different small web apps (`/api`, `/admin`, `/`) each as separate Deployments and Services. Create a single `Ingress` resource that routes traffic to the correct backend based on the URL path. Also configure a second Ingress rule using a different hostname (you can fake this with `/etc/hosts`).

#### Docker Images

- `hashicorp/http-echo:0.2.3` — use with different `-text` args for each service to identify which backend responded.

#### Deliverables

Three deployments, three services, one Ingress with path and host rules. Verify with curl using `Host:` headers.
