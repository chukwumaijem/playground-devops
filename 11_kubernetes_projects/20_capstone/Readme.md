### Project 20 — Capstone: Building a Production-Grade Platform

**Complexity: ★★★★★ | Open-ended**

#### Design Brief

This final project has no step-by-step instructions. You are given a set of requirements and it's your job to design and implement the solution using everything you've learned. This mirrors real-world work: you'll need to make architectural decisions, research gaps in your knowledge, and justify your choices.

#### The Requirements

Deploy a microservices application consisting of at least three services. The platform must meet all of the following:

- All services deployed via GitOps (Argo CD)
- TLS handled automatically via cert-manager
- NetworkPolicies enforcing least-privilege access between all services
- Database tier is a StatefulSet with automated backups implemented as a CronJob
- All services monitored via Prometheus with alerting rules configured (`PrometheusRule` CRDs)
- Full stack deployable to either cluster using different Helm values files
- HPA configured for all stateless tiers
- A `README.md` that explains every architectural decision made

#### Suggested Application: Google Online Boutique

Deploy Google's Online Boutique (`microservices-demo`) — a fully-featured e-commerce microservices app. Your job is **not** to run their existing manifests. Design and implement your own manifests that meet the requirements above, using the reference repo at `github.com/GoogleCloudPlatform/microservices-demo` only for context.

| Service                | Image                                                                    |
| ---------------------- | ------------------------------------------------------------------------ |
| Frontend               | `gcr.io/google-samples/microservices-demo/frontend:v0.10.1`              |
| Cart Service           | `gcr.io/google-samples/microservices-demo/cartservice:v0.10.1`           |
| Product Catalog        | `gcr.io/google-samples/microservices-demo/productcatalogservice:v0.10.1` |
| Currency Service       | `gcr.io/google-samples/microservices-demo/currencyservice:v0.10.1`       |
| Payment Service        | `gcr.io/google-samples/microservices-demo/paymentservice:v0.10.1`        |
| Shipping Service       | `gcr.io/google-samples/microservices-demo/shippingservice:v0.10.1`       |
| Email Service          | `gcr.io/google-samples/microservices-demo/emailservice:v0.10.1`          |
| Checkout Service       | `gcr.io/google-samples/microservices-demo/checkoutservice:v0.10.1`       |
| Recommendation Service | `gcr.io/google-samples/microservices-demo/recommendationservice:v0.10.1` |
| Ad Service             | `gcr.io/google-samples/microservices-demo/adservice:v0.10.1`             |
| Load Generator         | `gcr.io/google-samples/microservices-demo/loadgenerator:v0.10.1`         |

#### Deliverables

A Git repository containing everything needed to reproduce the full deployment from scratch on a fresh cluster, plus a `README.md` explaining every architectural decision.