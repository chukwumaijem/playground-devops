### Project 6 — Rolling Updates and Rollbacks

**Complexity: ★★☆☆☆ | Pure K8s**

#### Design Brief

One of Kubernetes' most powerful features is zero-downtime deployments via rolling updates. This project teaches you how the `RollingUpdate` strategy works under the hood — specifically the `maxSurge` and `maxUnavailable` parameters — and how to use `kubectl rollout` to manage and reverse deployments.

#### What to Build

Deploy v1 of an app (which returns "Version 1" in its response). Configure the Deployment with a deliberate rolling update strategy (e.g., `maxSurge: 1`, `maxUnavailable: 0`). While continuously curling the service, update the image to v2 and observe that you never get a failed request. Then roll back to v1 using `kubectl rollout undo`.

#### Docker Images

- `hashicorp/http-echo:0.2.3` for v1 with `-text="v1"` and again for v2 with `-text="v2"`.
- You can also use two different nginx configurations served via ConfigMap to simulate version changes.

#### Deliverables

Annotated deployment manifest, a shell script that curls in a loop, and notes on what you observe in `kubectl rollout history`.
