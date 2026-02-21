### Project 13 — Multi-Tier Application: Web + API + Database

**Complexity: ★★★★☆ | Pure K8s**

#### Design Brief

This is your first "real application" project. You'll deploy a three-tier architecture — a frontend, a backend API, and a database — wiring them together with Services and ConfigMaps. The challenge is designing the networking so each tier can only talk to the right neighbors, which sets you up for the Network Policy project that follows.

#### What to Build

Use the **Docker Voting App** — a real multi-tier application with a Python frontend, .NET worker backend, Node.js results frontend, Redis message queue, and PostgreSQL database. Deploy the full stack as Kubernetes manifests: the vote and result frontends as Deployments exposed via Services, the worker as a Deployment, Redis as a Deployment, and PostgreSQL as a StatefulSet with a PVC. Seed the database using a Kubernetes `Job`.

The app is simple to understand — users vote for cats or dogs, the worker processes votes via the Redis queue, and results appear in real time — but architecturally rich enough to exercise every K8s concept you've learned.

> **Note:** The official repo at `github.com/dockersamples/example-voting-app` has reference K8s manifests in the `k8s-specifications/` folder. Write your own first, then use these as a reference afterward.

#### Docker Images

| Component                    | Image                                          |
| ---------------------------- | ---------------------------------------------- |
| Vote frontend (Python/Flask) | `dockersamples/examplevotingapp_vote:latest`   |
| Results frontend (Node.js)   | `dockersamples/examplevotingapp_result:latest` |
| Worker backend (.NET)        | `dockersamples/examplevotingapp_worker:latest` |
| Message queue                | `redis:7.2-alpine`                             |
| Database                     | `postgres:15-alpine`                           |

#### Deliverables

Full set of manifests organized in a logical directory structure. This project is as much about organization as it is about K8s concepts.