### Project 5 — Health Checks: Liveness, Readiness, and Startup Probes

**Complexity: ★★☆☆☆ | Pure K8s**

#### Design Brief

Kubernetes can't inherently know if your app is healthy or ready to serve traffic — you have to tell it how to check. This project is about understanding the _three probe types_ and the very important distinction between liveness (should this pod be restarted?) and readiness (should this pod receive traffic?). Many production incidents come from misconfigured probes.

#### What to Build

Deploy a web app that has a `/healthz` endpoint for liveness and a `/ready` endpoint for readiness. Simulate a scenario where the app is alive but not ready (e.g., it delays its ready signal for 30 seconds on startup). Observe that traffic is withheld during that window. Then deliberately make the liveness probe fail and watch the restart cycle.

#### Docker Images

- `inanimate/echo-server:latest` — a lightweight HTTP echo server with a configurable `LATENCY` environment variable. Use this to inject an artificial startup delay that will cause your readiness probe to withhold traffic for a controlled window.
- For deliberately triggering liveness failure: run `nginx:1.25-alpine` and delete the default HTML file inside the running pod (`rm /usr/share/nginx/html/index.html`) so the `200 OK` liveness check becomes a `404`, triggering a restart.

#### Deliverables

Deployment with all three probes configured. Use `kubectl describe pod` and `kubectl get events` to narrate what happens during failure scenarios.