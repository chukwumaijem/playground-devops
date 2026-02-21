### Project 18 — GitOps with Argo CD

**Complexity: ★★★★★ | Introduces: Argo CD**

#### Design Brief

GitOps is the practice of using Git as the single source of truth for your infrastructure state. Argo CD continuously watches a Git repository and ensures the cluster state matches what's declared there. Instead of running `kubectl apply`, you push to Git and Argo CD does the rest. This is how most production teams manage Kubernetes today.

#### What to Build

Install Argo CD on your cluster using its install manifest. Create a Git repository (GitHub or GitLab) and push the Helm chart from Project 16 into it. Configure an Argo CD `Application` resource pointing at that repo. Make a change to the chart (update an image tag or replica count) in Git, push it, and watch Argo CD automatically sync the cluster. Experiment with sync policies: manual vs. automated, and with pruning enabled.

#### Docker Images

- Argo CD is installed from: `kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`
- The deployed application remains the Voting App Helm chart from Project 16 — no new images needed.

#### Deliverables

Argo CD Application manifest, Git repo structure, and a documented demonstration of a change flowing from Git commit to cluster state automatically.