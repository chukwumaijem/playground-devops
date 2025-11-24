# copy project files into the server

scp -r -i ./path/to/ssh/keys_file ./09_swarm_caddy_labels/main-swarm/ user@server_ip:~/destination

# create networks

- docker network create --driver overlay --attachable proxy
- docker network create --driver overlay --attachable backend
- docker network create --driver overlay logging

# deploy stacks

docker stack deploy -c docker-compose.proxy.yml proxy
docker stack deploy -c docker-compose.logging.yml logging
docker stack deploy -c docker-compose.app-backend.yml app-backend
docker stack deploy -c docker-compose.app-vote.yml app-vote
docker stack deploy -c docker-compose.app-result.yml app-result

# Access the apps

For proxmox setup without dns, just app these to you main systems /etc/hosts

<proxmox-vm-ip> vote.local
<proxmox-vm-ip> result.local

NOTE: Use the IP of the manager node where caddy is deployed
