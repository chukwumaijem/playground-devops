### Project 2 — Configuration and Secrets Management

**Complexity: ★☆☆☆☆ | Pure K8s**

#### Design Brief

Hardcoding configuration into container images is an antipattern. Kubernetes gives you two native primitives for this: `ConfigMap` for non-sensitive data and `Secret` for sensitive data. In this project you'll learn both, and importantly, the _two ways_ to consume them (environment variables vs. volume mounts) — each with different trade-offs.

#### What to Build

Deploy a simple app that reads its configuration from both a `ConfigMap` and a `Secret`. Use the ConfigMap to set an `APP_ENV` variable and a config file mounted at `/etc/app/config.ini`. Use a Secret to inject a `DB_PASSWORD` as an environment variable.

#### Key Concepts to Internalize

Ask yourself: what is the security difference between injecting a secret as an env var versus mounting it as a file? (Hint: think about what `kubectl describe pod` reveals and what gets logged.)

#### Docker Images

- `busybox:1.36` — run a shell script that prints the env vars and reads the config file, then sleeps.

#### Deliverables

`configmap.yaml`, `secret.yaml`, `deployment.yaml`. Use `kubectl exec` to verify the values are present inside the container.
