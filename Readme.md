# DevOps Playground

My Vagrant Playground for testing/learning various DevOps tools and technologies.

## 01 - Ubuntu 22.04

A basic Vagrant setup for provisioning a clean Ubuntu 22.04 (Jammy) virtual machine. This project serves as a foundation template for other projects, providing a minimal Ubuntu environment that can be extended with additional tooling and configurations. It uses VirtualBox as the provider and includes basic VM configuration options.

## 02 - Apache Custom Login

This project demonstrates hosting static websites with Apache web server using custom login forms and session-based authentication. It provisions two separate Ubuntu VMs using Vagrant, each running Apache with different configurations.

The project uses Ansible playbooks to automate the installation and configuration of Apache, including enabling required modules (session, session_cookie, session_crypto, auth_form, request, and macro). Each VM hosts a static website with a custom login form that uses Apache's authentication modules for secure access. The websites are served from custom virtual host configurations, and the default Apache site is disabled to ensure only the configured sites are accessible.

## 03 - Caddy Server

A Docker Swarm-based setup using Caddy as a reverse proxy and web server. This project demonstrates deploying a multi-service application stack where Caddy serves static websites from a marketing folder and acts as a reverse proxy for containerized admin and client applications.

The setup uses Docker Swarm for orchestration and showcases Caddy's automatic TLS certificate management capabilities. Caddy handles both on-demand TLS certificates for custom domains (via Let's Encrypt) and local TLS certificates for internal services, including support for wildcard domains. The project includes Docker image loading, volume management, and stack deployment automation through Vagrant provisioning scripts.

## 04 - Nomad

An exploration of HashiCorp Nomad for container orchestration. This project sets up a Nomad cluster and deploys containerized applications, including a Caddy web server and a colors application, using Nomad job specifications.

The setup demonstrates Nomad's job definition syntax, volume management with host volumes, and service registration. It includes Nomad agent configuration files for both server and client modes, showing how to configure a combined agent setup. The project uses Vagrant to provision the environment and includes scripts to load Docker images and install Nomad from HashiCorp's official repositories.

## 05 - Kubernetes Minikube

A learning environment for Kubernetes fundamentals using Minikube. This project provides a single-node Kubernetes cluster setup for experimenting with core Kubernetes concepts and resources.

The project includes example configurations for various Kubernetes resources including Pods, Deployments, ReplicaSets, and Services (ClusterIP, NodePort, and LoadBalancer types). It demonstrates basic Kubernetes operations like scaling, service discovery, and networking. The Vagrant setup installs kubectl and Minikube, with instructions for accessing the Kubernetes dashboard and proxying services from the host machine.

## 06 - Kubernetes Minikube with Helm

An extension of the Minikube project that introduces Helm, the Kubernetes package manager. This project demonstrates packaging the Docker voting app example into Helm charts and deploying it using Helm.

The project includes two approaches to Helm chart organization: a single monolithic chart that deploys all application components (database, Redis, vote UI, result UI, and worker), and a microservices approach with separate charts for each component. It covers Helm chart structure, templating with Go templates, values files, and chart dependencies. The setup shows how to package, sign, and install Helm charts, demonstrating best practices for managing Kubernetes applications at scale.

## 07 - Kubernetes with kubeadm

A production-like Kubernetes cluster setup using kubeadm for the Certified Kubernetes Administrator (CKA) course preparation. This project provisions a multi-node cluster with one control plane node and configurable worker nodes.

The setup supports both NAT and bridge networking modes, with automatic IP address discovery and DNS configuration. It includes scripts for setting up SSH access, configuring /etc/hosts files across all nodes, and preparing the environment for Kubernetes cluster initialization. The project is based on the KodeKloud CKA course setup and includes custom configurations for vim and tmux to match exam environment requirements.

## 08 - Proxmox

A collection of configurations and deployments for Proxmox-based infrastructure. This project includes setups for running containerized applications and monitoring stacks on Proxmox VMs.

The project contains Docker Compose configurations for application deployments and a comprehensive monitoring stack including Grafana, Prometheus, Loki, Alertmanager, and Caddy. It demonstrates VM network configuration, node labeling for Docker Swarm, and running production-like services in a homelab environment. The monitoring stack includes pre-configured dashboards, alerting rules, and log aggregation, providing a complete observability solution.

The monitoring services is deployed on a separate vm. While the docker-samples application is deployed on a 3-node swarm with alloy configured to forward logs to the monitoring server.

## 09 - Docker Swarm with Caddy Labels

A Docker Swarm deployment using Caddy Docker Proxy for automatic service discovery and reverse proxy configuration via Docker labels. This project demonstrates a microservices architecture with automatic HTTPS and service routing.

Here we reuse the monitoring server from the proxmox setup to receive logs from our logging stack. The logging stack (Grafana Alloy, cAdvisor, Node Exporter), backend stack (Redis, PostgreSQL, worker), and frontend stacks (vote and result stacks). Services are automatically discovered by Caddy through Docker labels, eliminating the need for manual reverse proxy configuration. The project uses overlay networks for service isolation.
