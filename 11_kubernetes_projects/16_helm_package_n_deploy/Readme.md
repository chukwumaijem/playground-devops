### Project 16 — Helm: Packaging and Deploying Applications

**Complexity: ★★★★☆ | Introduces: Helm**

#### Design Brief

Manually writing YAML for every environment becomes unmaintainable at scale. Helm is the Kubernetes package manager that introduces templating, versioning, and reusable charts. In this project you'll first _consume_ an existing Helm chart, then _create your own chart_ for the Voting App from Project 13.

#### What to Build

Install Helm in your environment. First, use `helm install` to deploy `kube-prometheus-stack` from the `prometheus-community` repo — notice how much complexity Helm is managing for you. Then, convert the manifests from Project 13 into a Helm chart with a `values.yaml` that parameterizes image tags, replica counts, and resource limits. Deploy it to both your single-node and multi-node clusters with different values files.

#### Docker Images

Same as Project 13 — the goal of this project is the packaging workflow, not a new application. The `kube-prometheus-stack` Helm chart manages its own images automatically.

#### Deliverables

A working Helm chart directory for the Voting App. A `values-dev.yaml` and `values-prod.yaml` demonstrating environment-specific configuration.