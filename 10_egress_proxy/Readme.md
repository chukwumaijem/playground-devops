# Egress choke point for apps

Only the Caddy egress proxy can reach the internet. All other containers must go through it via `HTTP_PROXY`/`HTTPS_PROXY`.

## How it works

Docker's `--internal` flag on an overlay network tells Docker to block external connectivity for containers on that network. The proxy is on both an internal network (to talk to apps and allow apps talk to it) and a non-internal network (to reach the internet). Docker allows egress only for containers that have at least one non-internal network.

| Network        | Type                  | Who joins    | Purpose                         |
| -------------- | --------------------- | ------------ | ------------------------------- |
| `app-network`  | overlay, **internal** | proxy + apps | App <-> proxy communication     |
| `proxy-egress` | overlay               | proxy only   | Enables proxy's internet access |

Traffic flow:

```
App container (app-network, internal)
  → HTTP CONNECT to caddy-egress:3128 (overlay, no iptables involved)
  → Proxy container (app-network + proxy-egress)
  → Proxy connects to target (docker_gwbridge → internet, Docker allows it)

App container tries direct internet access
  → docker_gwbridge → Docker blocks it (container is on internal network only)
```

## Setup

### 1. Create networks

```bash
# Non-internal: enables proxy's internet access
docker network create --driver overlay --subnet 10.0.1.0/24 --attachable proxy-egress

# Internal: blocks direct internet access for app containers
docker network create --driver overlay --internal --subnet 10.0.2.0/24 --attachable app-network
```

### 2. Deploy the proxy

```bash
docker stack deploy -c docker-compose.proxy.yml proxy
```

### 3. Deploy apps

```bash
docker stack deploy -c docker-compose.app.yml app
```

### 4. (Optional) Ansible for private DB access

If containers need to reach a private resource directly (e.g. managed DB), the Ansible role adds a DOCKER-USER ACCEPT rule that overrides the `--internal` block for specific destination subnets. Essentially this rule runs before the docker's rule that blocks internal network from reaching the internet, and allows your containers in the app-network to reach the specified IPs/subnets.

```bash
cd ansible
ansible-playbook -i inventory.txt configure-network.yml
```

Set private destinations in the playbook or inventory:

```yaml
allowed_external_ips:
  - "10.116.0.0/20"
```

This is important for non HTTP traffic like (Postgres, MySQL, Redis), that must go direct. You will also need to add the hosts for these connections to the NO_PROXY list in your env vars.

| Check                                                                              | Expected                      |
| ---------------------------------------------------------------------------------- | ----------------------------- |
| App, no proxy: `curl https://google.com`                                           | Fails (blocked by --internal) |
| App, with proxy: `curl -x http://caddy-egress:3128 https://google.com`             | Works                         |
| App → private DB (if configured via iptables using the ansible script or manually) | Works without proxy           |
| Proxy → internet directly                                                          | Works                         |

## Troubleshooting

### App can still reach the internet directly

`app-network` is probably not internal. Check:

```bash
docker network inspect app-network --format '{{.Internal}}'
```

If it prints `false`, recreate the network with `--internal`:

```bash
docker stack rm app
docker stack rm proxy
docker network rm app-network
docker network create --driver overlay --internal --subnet 10.0.1.0/24 --attachable app-network
docker stack deploy -c docker-compose.proxy.yml proxy
docker stack deploy -c docker-compose.app.yml app
```

### App can't reach proxy

Make sure the proxy is on `app-network` (see `docker-compose.proxy.yml`). caddy-egress service much be connected to both networks for DNS resolution and connectivity.

### Proxy can't reach the internet

Make sure the proxy is on `proxy-egress` (non-internal). Check:

```bash
docker network inspect proxy-egress --format '{{.Internal}}'
# Must be: false
```

### Private DB not reachable

Run the Ansible playbook with `allowed_external_ips` set. The DOCKER-USER ACCEPT rule is processed before Docker's --internal isolation, so it overrides the block for those specific subnets.

## Useful commands

```bash
# Check if a network is internal
docker network inspect <network-name> --format '{{.Internal}}'

# List DOCKER-USER rules
sudo iptables -L DOCKER-USER -n -v --line-numbers
```
