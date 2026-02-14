# Egress proxy: one way out

Only the Caddy proxy is allowed to reach the internet. All other containers use it for outbound HTTP/HTTPS. Everything else is blocked by iptables.

---

## What this does

- **Apps** set `HTTP_PROXY` / `HTTPS_PROXY` to the proxy. Their traffic goes: app → proxy → internet.
- **Direct** outbound from app containers is **dropped** by the firewall.
- **Proxy** runs on the host (with host networking) and listens on the Docker bridge so containers reach it as `host.docker.internal:3128`. Proxy needs to be run on each individual host using docker compose(not swarm), installed as direct binary(not tested).
- **Access to the proxy** is restricted: only connections from Docker networks (e.g. overlay / `docker_gwbridge`) are allowed to port 3128. Other hosts (and direct curl from the node) cannot use the proxy.

---

## Architecture (plain words)

1. **iptables (DOCKER-USER)**
   Any packet leaving a container toward the internet is dropped, except:
   - return traffic for already-open connections,
   - traffic to `allowed_external_ips` (e.g. your DB subnet).

2. **Proxy on the host**
   Caddy runs via Docker Compose with **host network**. So it’s not in a container network namespace and isn’t affected by the DOCKER-USER drop. It can reach the internet normally.

3. **Where the proxy listens**
   Caddy binds to the **docker0** address. Containers use `host.docker.internal:3128`; that resolves to the host and hits the proxy on docker0.

4. **Who can hit the proxy (PROXY-INPUT)**
   Only these sources are allowed to connect to port 3128:
   - **docker0** (172.17.0.0/16), **docker_gwbridge** (172.18.0.0/16) — so overlay/Swarm containers on the node can reach the proxy.
     Everything else (e.g. another machine on the LAN, or curl from the node itself) is dropped or does not work.

5. **Apps**
   Your app stack runs on an overlay network (e.g. `app-network`). Containers set `HTTP_PROXY`/`HTTPS_PROXY` to `http://host.docker.internal:3128` and put local/private hosts in `NO_PROXY`.

---

## Setup

### 1. Push config with Ansible

From your machine (or a control host):

```bash
cd ansible
ansible-playbook -i inventory.txt update-all-files.yml   # Caddyfile, compose, Dockerfile
ansible-playbook -i inventory.txt configure-network.yml  # iptables: egress block + proxy allow
```

- **update-all-files** copies the require configs into the node and handles IP address substitution.

- **configure-network** sets DOCKER-USER (block container egress, allow `allowed_external_ips`) and PROXY-INPUT (allow 3128 only from docker0 and docker_gwbridge).

Tune `configure-network.yml` if needed: `egress_interface`, `allowed_external_ips`, and `proxy_allow_sources` (the last two are derived from Ansible interface facts by default).

### 2. On the proxy host: start the proxy

Use **Compose** on the node where the proxy should run (not `docker stack deploy` — Swarm ignores host networking). From the directory where you pushed the files (e.g. `egress_proxy_dest`):

```bash
docker compose -f docker-compose.proxy.yml up -d
```

Verify the proxy is up (e.g. `docker compose -f docker-compose.proxy.yml logs` or that app containers can reach the internet via the proxy).

### 3. Deploy the app stack

From the same (or another) node, with the same compose file you deployed via Ansible:

```bash
docker stack deploy -c docker-compose.app.yml app
```

App containers use `host.docker.internal:3128` as their proxy.

### 4. (Optional) Private DB or other direct targets

If containers must reach a private subnet (e.g. a DB) without going through the proxy, add that subnet to `allowed_external_ips` in `configure-network.yml` and re-run the playbook. Put those hosts in your app’s `NO_PROXY` so they’re not sent to the proxy.

---

## Quick checks

| What you check                                                           | What you expect                            |
| ------------------------------------------------------------------------ | ------------------------------------------ |
| From app container: `curl https://ifconfig.me` (with proxy env)          | Your public IP; traffic went through proxy |
| From app container: `curl https://google.com` without proxy              | Fails (blocked by iptables)                |
| From another machine or from the node: `curl -x http://<proxy>:3128 ...` | Fails (PROXY-INPUT or no listener)         |

---

## Files you care about

- **Caddyfile.egress** — Caddy config (Ansible fills in the bind address; usually docker0).
- **docker-compose.proxy.yml** — Proxy service (host network). Run with `docker compose`, not `docker stack deploy`.
- **docker-compose.app.yml** — App stack; sets `HTTP_PROXY`/`HTTPS_PROXY` to `host.docker.internal:3128`.
- **ansible/configure-network.yml** — iptables (egress block + proxy allow list).
- **ansible/update-all-files.yml** — Deploy Caddyfile, compose files, Dockerfile to the server.
