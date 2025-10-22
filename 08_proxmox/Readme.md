docker node update --label-add customer=one swarm2
docker node update --label-add private=true swarm2

docker node ls -f "label=customer"
docker node ls -f "label=customer=one"

docker node inspect swarm2 --format '{{ json .Spec.Labels }}'
docker node ps --format '{{ .Name }}' swarm2 | cut -d. -f1 | sort -u
