# Squid egress proxy (host) + DOCKER-USER

Deny-by-default container egress. Apps use a **host** Squid (`HTTP_PROXY` → `host.docker.internal:3128`). Direct internet from containers is dropped by iptables.

Sequel to `10_egress_proxy` (Caddy).

---

## Layout

| Path                       | Purpose                                         |
| -------------------------- | ----------------------------------------------- |
| `ansible/setup-egress.yml` | Install Squid, allowlist, DOCKER-USER rules     |
| `ansible/roles/egress/`    | Role (config, firewall)                         |
| `app.yml`                  | Swarm demo: compliant (proxy) vs rogue (direct) |

---

## Setup

Prerequisites: Ubuntu host with Docker (Swarm optional for the demo apps).

### 1. Inventory

```bash
printf '[web]\n%s\n' 'YOUR_HOST' > ansible/inventory.txt
```

### 2. Apply egress (from this directory)

```bash
cd ansible
ansible-playbook -i inventory.txt setup-egress.yml -u ubuntu -k -K
```

- `-k` SSH password, `-K` sudo password
- Or use a key: drop `-k` and pass `--private-key …`

### 3. Demo apps

```bash
docker stack deploy -c app.yml app
docker service logs -f app_app_compliant
docker service logs -f app_app_rogue
```

Expect: compliant → `worldclockapi.com` **200**, `jsonplaceholder.typicode.com` **error http=403**. Rogue → timeouts / `http=000` for both.

---

## How it works

1. **DOCKER-USER** — ACCEPT ESTABLISHED; optional `allowed_external`; DROP on default-route iface; RETURN.
2. **Squid on the host** — traffic uses OUTPUT (not DOCKER-USER). Binds to docker0 so `:3128` is not on the public interface.
3. **Allowlist** — `files/allowlists/allow-test.txt` (`worldclockapi.com`). Add files there; the role copies the whole directory. Wire new files in `templates/squid.conf.j2`.

---

## Checks

```bash
ip -4 route show default
ss -lntp | grep 3128
sudo iptables -L DOCKER-USER -n -v --line-numbers
```
