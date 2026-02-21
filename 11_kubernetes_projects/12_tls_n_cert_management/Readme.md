### Project 12 — TLS Termination and Certificate Management

**Complexity: ★★★★☆ | Introduces: cert-manager**

#### Design Brief

Production services need HTTPS. This project introduces `cert-manager`, the de facto standard for automating TLS certificate issuance in Kubernetes. You'll create a self-signed `ClusterIssuer`, have cert-manager provision a certificate as a Secret, and configure your Ingress to terminate TLS. This project illustrates a key Kubernetes pattern: a controller watching a custom resource and taking action.

#### What to Build

Install cert-manager (via its manifest, not Helm, to keep things transparent). Create a `ClusterIssuer` using the `selfsigned` issuer type. Create a `Certificate` resource and observe cert-manager creating the corresponding Secret. Wire the certificate into your Ingress from Project 11 so it serves HTTPS. Verify with `curl -k` and inspect the certificate with `openssl`.

#### Docker Images

- `traefik/whoami:latest` — a tiny Go web server that dumps request details including headers. Ideal for verifying that TLS headers and certificates are being passed through correctly.
- cert-manager images are managed by its install manifest automatically.

#### Deliverables

cert-manager install manifest, `ClusterIssuer`, `Certificate`, updated `Ingress`. The key learning is watching CRD-driven automation in action.