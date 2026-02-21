### Project 4 — Persistent Storage with PVs and PVCs

**Complexity: ★★☆☆☆ | Pure K8s**

#### Design Brief

Pods are ephemeral — when a pod dies, its filesystem goes with it. This project introduces the storage subsystem: `PersistentVolume` (the actual storage), `PersistentVolumeClaim` (a pod's request for storage), and `StorageClass` (which automates PV creation). MicroK8s has the `hostpath-storage` addon which provides a default StorageClass — enable it.

#### What to Build

Deploy a single-replica app that writes a timestamp to a file every 10 seconds. Kill the pod and verify the file survives in a new pod because it's backed by a PVC. Also experiment with `ReadWriteOnce` and what happens when you try to schedule two pods using the same PVC.

#### Docker Images

- `busybox:1.36` with a shell loop: `while true; do date >> /data/log.txt; sleep 10; done`

#### Deliverables

`pvc.yaml` and `deployment.yaml`. Show the log file persisting across pod restarts via `kubectl exec cat /data/log.txt`.
